extends Node

const MAX_PLAYER_LIVES: int = 3
var player_lives: int = 3
var is_player_dead: bool = false
const INITIAL_LEVEL: LEVELS = LEVELS.LEVEL_ONE
var current_level: LEVELS

enum LEVELS {
	LEVEL_ONE,
	LEVEL_TWO,
}

var game_data = {
	LEVELS.LEVEL_ONE: {
		"id": LEVELS.LEVEL_ONE,
		"scene": "res://scenes/levels/test_level.tscn",
		"best_time": 999999999,
		"last_time": 0,
		"next_level": {
				"id": LEVELS.LEVEL_TWO,
				"scene": "res://scenes/levels/second_test_level.tscn"
			}
	},
	LEVELS.LEVEL_TWO: {
		"id": LEVELS.LEVEL_TWO,
		"scene": "res://scenes/levels/second_test_level.tscn",
		"best_time": 999999999,
		"last_time": 0,
		"next_level": null
	}
}

func remove_player_lives(lives: int) -> void:
	player_lives -= lives
	Events.life_lost.emit()

	if player_lives <= 0:
		is_player_dead = true
		player_lives = 0
		Events.game_over.emit()
 
func reset_player_lives() -> void:
	player_lives = MAX_PLAYER_LIVES
	is_player_dead = false

#NOTE: godot 4/gdscript does not handle well multitype returns
#This returns Dictionary or null 
func handle_finished_level(level: LEVELS, time: int):
	var finished_level = game_data[level]
	finished_level.last_time = time

	if time < finished_level.best_time:
		finished_level.best_time = time
	
	game_data[level] = finished_level
	if finished_level.next_level == null:
		return null
		
	current_level = finished_level.next_level.id	
	
	return finished_level.next_level
	
