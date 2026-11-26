"""P1: 게임 전반. 균형·패턴·잡몹 같은 것."""
from sim.game import World

IDLE = {"move": (0, 0), "attack": False, "dodge": False}


def test_dodge_gives_invulnerability():
    w = World(seed=1)
    w.step({"move": (1, 0), "attack": False, "dodge": True})
    assert w.player_invuln > 0


def test_slime_king_summons_minions():
    w = World(seed=1, scene="boss:slime_king")
    w.player.hp = 10**6
    for _ in range(400):
        w.step(IDLE)
        if w.enemies:
            break
    assert w.enemies


def test_bone_knight_fires_ring():
    w = World(seed=1, scene="boss:bone_knight")
    w.player.hp = 10**6
    for _ in range(400):
        w.step(IDLE)
        if w.projectiles:
            break
    assert len(w.projectiles) >= 6


def test_boss_telegraphs_before_dash():
    w = World(seed=1, scene="boss:bone_knight")
    w.player.hp = 10**6
    seen = []
    for _ in range(300):
        w.step(IDLE)
        if not seen or seen[-1] != w.boss.state:
            seen.append(w.boss.state)
    assert "telegraph" in seen and seen.index("telegraph") < seen.index("dash")


def test_enemies_do_not_stack():
    w = World(seed=3, scene="max_enemies", enemy_count=60)
    for _ in range(120):
        w.step(IDLE)
    pts = {(round(e.x), round(e.y)) for e in w.enemies}
    assert len(pts) > len(w.enemies) * 0.8
