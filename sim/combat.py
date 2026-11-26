"""전투 판정. 이 파일을 고치면 보스 봇 테스트가 같이 돈다 (test_map.json)."""
import math

ATTACK_RANGE = 46
ATTACK_DAMAGE = 12
BOSS_CONTACT_DAMAGE = 14
BOSS_DASH_DAMAGE = 22
ENEMY_DAMAGE = 3
PROJ_DAMAGE = 8
HURT_INVULN = 24


def _hit_player(world, dmg):
    if world.player_invuln > 0:
        return
    world.player.hp -= dmg
    world.player_invuln = HURT_INVULN


def resolve(world):
    p = world.player
    b = world.boss

    # 플레이어 공격
    if world.player_attack_active:
        if b is not None and b.alive and math.hypot(b.x - p.x, b.y - p.y) <= ATTACK_RANGE + b.r:
            b.hp -= ATTACK_DAMAGE
            if b.hp <= 0:
                b.alive = False
        for e in world.enemies:
            if math.hypot(e.x - p.x, e.y - p.y) <= ATTACK_RANGE + e.r:
                e.hp -= ATTACK_DAMAGE
                if e.hp <= 0:
                    e.alive = False

    # 보스 접촉
    if b is not None and b.alive and math.hypot(b.x - p.x, b.y - p.y) <= b.r + p.r:
        _hit_player(world, BOSS_DASH_DAMAGE if b.state == "dash" else BOSS_CONTACT_DAMAGE)

    # 잡몹 접촉 + 서로 밀어내기 (모든 쌍 비교)
    es = world.enemies
    n = len(es)
    for i in range(n):
        a = es[i]
        if math.hypot(a.x - p.x, a.y - p.y) <= a.r + p.r:
            _hit_player(world, ENEMY_DAMAGE)
        for j in range(i + 1, n):
            c = es[j]
            dx, dy = c.x - a.x, c.y - a.y
            d = math.hypot(dx, dy)
            m = a.r + c.r
            if 0 < d < m:
                push = (m - d) / 2 / d
                a.x -= dx * push
                a.y -= dy * push
                c.x += dx * push
                c.y += dy * push

    # 투사체
    for q in world.projectiles:
        if q.alive and math.hypot(q.x - p.x, q.y - p.y) <= q.r + p.r:
            _hit_player(world, PROJ_DAMAGE)
            q.alive = False
