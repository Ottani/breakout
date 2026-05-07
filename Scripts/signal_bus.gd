extends Node

@warning_ignore("unused_signal")
signal brick_hit(brick: Brick)

@warning_ignore("unused_signal")
signal life_updated(lives: int)

@warning_ignore("unused_signal")
signal points_updated(points: int)

@warning_ignore("unused_signal")
signal power_up_picked(power_up: PowerUpData.Type)

@warning_ignore("unused_signal")
signal xp_updated(curr_xp: int, max_xp: int)

@warning_ignore("unused_signal")
signal level_updated(level: int)
