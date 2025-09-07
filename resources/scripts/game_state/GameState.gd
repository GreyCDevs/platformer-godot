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
