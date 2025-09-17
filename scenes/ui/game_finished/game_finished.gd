extends ColorRect

@onready var to_start_menu_button: Button = %ToStartMenuButton
@onready var scoreboard_menu_button: Button = %ScoreboardMenuButton

func _ready() -> void:
	to_start_menu_button.grab_focus()

func _on_button_pressed() -> void:
	SceneManager.handle_change_scene("res://scenes/ui/menu/start_menu/start_menu.tscn")


func _on_scoreboard_menu_button_pressed() -> void:
	GameState.back_from_score_board = "res://scenes/ui/game_finished/game_finished.tscn"
	SceneManager.handle_change_scene("res://scenes/ui/score_board/score_board.tscn")
