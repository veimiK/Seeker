extends Node

signal scoreUpdated 
signal playerDied

var score: = 0 setget setScore
var deaths: = 0 setget setDeaths

func reset() -> void:
	score = 0 
	deaths = 0

func setScore(value: int) -> void:
	score = value 
	emit_signal("scoreUpdated")
	return
	
func setDeaths(value: int) -> void:
	deaths = value
	emit_signal("playerDied")
	return
	
