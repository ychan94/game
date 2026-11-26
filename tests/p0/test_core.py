"""P0: 깨지면 게임이 안 되는 것. 빠르게(수 초 안에) 끝나야 한다."""
from sim.game import BOSSES, World


def test_world_starts_every_scene():
    for scene in ["empty", "max_enemies"] + [f"boss:{b}" for b in BOSSES]:
        w = World(seed=1, scene=scene)
        w.step({"move": (0, 0), "attack": False, "dodge": False})
        assert w.frame == 1, scene


def test_player_moves_and_stays_in_arena():
    w = World(seed=1)
    x0 = w.player.x
    for _ in range(10):
        w.step({"move": (1, 0), "attack": False, "dodge": False})
    assert w.player.x > x0
    for _ in range(1000):
        w.step({"move": (1, 1), "attack": False, "dodge": False})
    assert w.player.x <= 800 and w.player.y <= 600


def test_attack_damages_boss():
    w = World(seed=1, scene="boss:slime_king")
    w.boss.x, w.boss.y = w.player.x, w.player.y - 60
    hp = w.boss.hp
    w.step({"move": (0, 0), "attack": True, "dodge": False})
    assert w.boss.hp < hp


def test_player_can_die_and_game_ends():
    w = World(seed=1, scene="boss:slime_king")
    w.player.hp = 1
    for _ in range(3000):
        if w.done:
            break
        w.step({"move": (0, 0), "attack": False, "dodge": False})
    assert w.done and w.result == "lose"


def test_same_seed_same_result():
    a, b = World(seed=7, scene="boss:bone_knight"), World(seed=7, scene="boss:bone_knight")
    for _ in range(600):
        a.step({"move": (1, 0), "attack": True, "dodge": False})
        b.step({"move": (1, 0), "attack": True, "dodge": False})
    assert a.state_hash() == b.state_hash()
