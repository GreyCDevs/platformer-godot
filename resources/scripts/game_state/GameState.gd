extends Node

const MAX_PLAYER_LIVES: int = 3
var player_lives: int = 3
var is_player_dead: bool = false
const INITIAL_LEVEL: LEVELS = LEVELS.LEVEL_ONE
var current_level: LEVELS
var player_name: String = 'El chonko'
var back_from_score_board: String
var score_board_disabled: bool = true

enum LEVELS {
	LEVEL_ONE,
	LEVEL_TWO,
	LEVEL_THREE
}

var game_data = {
	LEVELS.LEVEL_ONE: {
		"id": LEVELS.LEVEL_ONE,
		"name": "Level 1",
		"scene": "res://scenes/levels/level_one.tscn",
		"best_time": 999999999,
		"last_time": 0,
		"score_board": [],
		"next_level": {
				"id": LEVELS.LEVEL_TWO,
				"scene": "res://scenes/levels/level_two.tscn"
			}
	},
	LEVELS.LEVEL_TWO: {
		"id": LEVELS.LEVEL_TWO,
		"name": "Level 2",
		"scene": "res://scenes/levels/level_two.tscn",
		"best_time": 999999999,
		"last_time": 0,
		"score_board": [],
		"next_level": {
				"id": LEVELS.LEVEL_THREE,
				"scene": "res://scenes/levels/level_three.tscn"
			}
	},
	LEVELS.LEVEL_THREE: {
		"id": LEVELS.LEVEL_THREE,
		"name": "Level 3",
		"scene": "res://scenes/levels/level_three.tscn",
		"best_time": 999999999,
		"last_time": 0,
		"score_board": [],
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
	score_board_disabled = false
	var finished_level = game_data[level]
	finished_level.last_time = time

	if time < finished_level.best_time:
		finished_level.best_time = time
	
	finished_level.score_board.append({
		"name": player_name,
		"time": time
	})
	
	game_data[level] = finished_level

	if finished_level.next_level == null:
		return null
		
	current_level = finished_level.next_level.id	
	
	return finished_level.next_level
	
func does_current_level_have_record() -> bool: 
	return game_data[current_level].score_board.size() > 0

func get_current_level_record() -> int:
	return game_data[current_level].best_time
	
func set_player_name(new_name: String) -> void:
	player_name = new_name
