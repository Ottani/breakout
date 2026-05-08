extends Node

var initial_xp_level_up: int = 10
var xp_growth: float = 1.2

var curr_xp: int = 0
var curr_level: int = 1
var level_up_xp: int


func reset() -> void:
	level_up_xp = initial_xp_level_up
	curr_xp = 0
	curr_level = 1
	SignalBus.xp_updated.emit(curr_xp, level_up_xp)
	SignalBus.level_updated.emit(curr_level)


func add_xp(xp: int) -> void:
	curr_xp += xp
	SignalBus.xp_updated.emit(curr_xp, level_up_xp)
	while curr_xp >= level_up_xp:
		curr_xp -= level_up_xp
		if curr_xp < 0:
			curr_xp = 0
		curr_level += 1
		SignalBus.level_updated.emit(curr_level)
		level_up_xp = roundi(xp_growth * level_up_xp)
		SignalBus.xp_updated.emit(curr_xp, level_up_xp)
