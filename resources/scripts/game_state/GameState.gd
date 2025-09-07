extends Node

const MAX_PLAYER_LIVES: int = 3
var player_lives: int = 3
var is_player_dead: bool = false

func remove_player_lives(lives: int) -> void:
	player_lives -= lives
	if player_lives <= 0:
		is_player_dead = true
		player_lives = 0
 
func reset_player_lives() -> void:
	player_lives = MAX_PLAYER_LIVES
	is_player_dead = false
