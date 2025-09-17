extends CenterContainer

@onready var start_game_button: Button = %StartGameButton
@onready var score_board_button: Button = %ScoreBoardButton

func _ready() -> void:
	RenderingServer.set_default_clear_color("black")
	start_game_button.grab_focus()
	score_board_button.disabled = GameState.score_board_disabled
	get_tree().paused = false

func _on_start_game_button_pressed() -> void:
	SceneManager.handle_change_scene("res://scenes/ui/menu/player_name_selection/player_name_selection.tscn")

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()


func _on_score_board_button_pressed() -> void:
	GameState.back_from_score_board = "res://scenes/ui/menu/start_menu/start_menu.tscn"
	SceneManager.handle_change_scene("res://scenes/ui/score_board/score_board.tscn")
