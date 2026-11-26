"""예시 게임 시뮬레이션 (화면 없음).

실제 게임으로 바꿀 때: 아래 공개 API만 같은 모양으로 맞추면
테스트·보스 봇·성능 측정판이 그대로 동작한다.

    World(seed, scene)      scene = "boss:<이름>" | "max_enemies" | "empty"
    world.step(inputs)      inputs = {"move": (dx, dy), "attack": bool, "dodge": bool}
    world.observe()         봇이 볼 수 있는 정보(화면에 보이는 것만)
    world.done / world.result
    world.state_hash()      회귀 비교용 상태 지문
    World.SYSTEMS           프레임마다 도는 함수 이름 (성능 측정용)
"""
import hashlib
import math
import random
import struct

from sim import combat

FPS = 60
DT = 1.0 / FPS
ARENA_W, ARENA_H = 800.0, 600.0

BOSSES = {
    # 이름: (체력, 대기 프레임, 예고 프레임, 돌진 프레임, 돌진 속도, 패턴)
    "slime_king": dict(hp=300, idle=70, telegraph=35, dash=22, dash_speed=9.0, pattern="summon"),
    "bone_knight": dict(hp=280, idle=60, telegraph=30, dash=18, dash_speed=11.0, pattern="ring"),
}


class Unit:
    __slots__ = ("x", "y", "vx", "vy", "r", "hp", "max_hp", "speed", "kind", "cd", "timer", "state", "tx", "ty", "alive")

    def __init__(self, kind, x, y, r, hp, speed):
        self.kind, self.x, self.y, self.r = kind, x, y, r
        self.hp = self.max_hp = hp
        self.speed = speed
        self.vx = self.vy = 0.0
        self.cd = 0
        self.timer = 0
        self.state = "idle"
        self.tx = self.ty = 0.0
        self.alive = True


class World:
    SYSTEMS = ("update_player", "update_boss", "update_enemies", "update_projectiles", "resolve_combat", "cleanup")

    def __init__(self, seed=1, scene="empty", enemy_count=400):
        self.rng = random.Random(seed)
        self.frame = 0
        self.done = False
        self.result = None
        self.player = Unit("player", ARENA_W / 2, ARENA_H * 0.8, 12, 100, 3.2)
        self.player_attack_cd = 0
        self.player_attack_active = 0
        self.player_dodge_cd = 0
        self.player_invuln = 0
        self.enemies = []
        self.projectiles = []
        self.boss = None
        self.boss_name = None
        self.inputs = {"move": (0, 0), "attack": False, "dodge": False}
        if scene.startswith("boss:"):
            name = scene.split(":", 1)[1]
            spec = BOSSES[name]
            self.boss_name = name
            self.boss = Unit("boss", ARENA_W / 2, ARENA_H * 0.25, 34, spec["hp"], 1.6)
            self.boss_spec = spec
            self.boss.timer = spec["idle"]
        elif scene == "max_enemies":
            for _ in range(enemy_count):
                self.spawn_enemy(self.rng.uniform(0, ARENA_W), self.rng.uniform(0, ARENA_H * 0.5))

    # ---------- 공개 API ----------
    def step(self, inputs):
        if self.done:
            return
        self.inputs = inputs
        for name in self.SYSTEMS:
            getattr(self, name)()
        self.frame += 1

    def observe(self):
        p, b = self.player, self.boss
        return {
            "frame": self.frame,
            "player": (p.x, p.y, p.hp),
            "attack_ready": self.player_attack_cd == 0,
            "dodge_ready": self.player_dodge_cd == 0,
            "boss": None if b is None or not b.alive else {
                "x": b.x, "y": b.y, "hp": b.hp, "state": b.state,
                "target": (b.tx, b.ty) if b.state in ("telegraph", "dash") else None,
            },
            "enemies": [(e.x, e.y) for e in self.enemies],
            "projectiles": [(q.x, q.y, q.vx, q.vy) for q in self.projectiles],
        }

    def state_hash(self):
        h = hashlib.sha256()
        units = [self.player] + ([self.boss] if self.boss else []) + self.enemies + self.projectiles
        for u in units:
            h.update(struct.pack("<ddd", round(u.x, 6), round(u.y, 6), float(u.hp)))
        h.update(struct.pack("<i", self.frame))
        return h.hexdigest()[:16]

    # ---------- 시스템 ----------
    def spawn_enemy(self, x, y):
        self.enemies.append(Unit("enemy", x, y, 8, 20, 1.4))

    def update_player(self):
        p = self.player
        dx, dy = self.inputs.get("move", (0, 0))
        n = math.hypot(dx, dy)
        if n > 0:
            dx, dy = dx / n, dy / n
        speed = p.speed
        if self.inputs.get("dodge") and self.player_dodge_cd == 0:
            self.player_dodge_cd = 45
            self.player_invuln = max(self.player_invuln, 14)
            p.timer = 12  # 구르기 지속
        if p.timer > 0:
            speed *= 2.6
            p.timer -= 1
        p.x = min(max(p.x + dx * speed, p.r), ARENA_W - p.r)
        p.y = min(max(p.y + dy * speed, p.r), ARENA_H - p.r)
        if self.inputs.get("attack") and self.player_attack_cd == 0:
            self.player_attack_cd = 20
            self.player_attack_active = 1
        else:
            self.player_attack_active = 0
        self.player_attack_cd = max(0, self.player_attack_cd - 1)
        self.player_dodge_cd = max(0, self.player_dodge_cd - 1)
        self.player_invuln = max(0, self.player_invuln - 1)

    def update_boss(self):
        b = self.boss
        if b is None or not b.alive:
            return
        s = self.boss_spec
        p = self.player
        b.timer -= 1
        if b.state == "idle":
            ang = math.atan2(p.y - b.y, p.x - b.x)
            b.x += math.cos(ang) * b.speed
            b.y += math.sin(ang) * b.speed
            if b.timer <= 0:
                b.state, b.timer = "telegraph", s["telegraph"]
                b.tx, b.ty = p.x, p.y
        elif b.state == "telegraph":
            if b.timer <= 0:
                b.state, b.timer = "dash", s["dash"]
                ang = math.atan2(b.ty - b.y, b.tx - b.x)
                b.vx, b.vy = math.cos(ang) * s["dash_speed"], math.sin(ang) * s["dash_speed"]
        elif b.state == "dash":
            b.x = min(max(b.x + b.vx, b.r), ARENA_W - b.r)
            b.y = min(max(b.y + b.vy, b.r), ARENA_H - b.r)
            if b.timer <= 0:
                b.state, b.timer = "recover", 40
                if s["pattern"] == "summon":
                    for _ in range(3):
                        self.spawn_enemy(b.x + self.rng.uniform(-40, 40), b.y + self.rng.uniform(-40, 40))
                else:
                    for i in range(8):
                        a = i * math.tau / 8 + self.rng.uniform(0, 0.3)
                        q = Unit("proj", b.x, b.y, 6, 1, 0)
                        q.vx, q.vy = math.cos(a) * 3.5, math.sin(a) * 3.5
                        self.projectiles.append(q)
        elif b.state == "recover":
            if b.timer <= 0:
                b.state, b.timer = "idle", s["idle"]

    def update_enemies(self):
        p = self.player
        for e in self.enemies:
            ang = math.atan2(p.y - e.y, p.x - e.x)
            e.x += math.cos(ang) * e.speed
            e.y += math.sin(ang) * e.speed

    def update_projectiles(self):
        for q in self.projectiles:
            q.x += q.vx
            q.y += q.vy
            if not (-20 < q.x < ARENA_W + 20 and -20 < q.y < ARENA_H + 20):
                q.alive = False

    def resolve_combat(self):
        combat.resolve(self)

    def cleanup(self):
        self.enemies = [e for e in self.enemies if e.alive]
        self.projectiles = [q for q in self.projectiles if q.alive]
        if self.player.hp <= 0:
            self.done, self.result = True, "lose"
        elif self.boss is not None and not self.boss.alive:
            self.done, self.result = True, "win"
