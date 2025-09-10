extends ColorRect

@onready var to_start_menu_button: Button = %ToStartMenuButton
@onready var scoreboard_menu_button: Button = %ScoreboardMenuButton

func _ready() -> void:
	to_start_menu_button.grab_focus()

func _on_button_pressed() -> void:
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/ui/menu/start_menu/start_menu.tscn")
	LevelTransition.fade_from_black()


func _on_scoreboard_menu_button_pressed() -> void:
	GameState.back_from_score_board = "res://scenes/ui/game_finished/game_finished.tscn"
	
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/ui/score_board/score_board.tscn")
	LevelTransition.fade_from_black()
