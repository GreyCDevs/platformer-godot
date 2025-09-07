extends CenterContainer

@onready var start_game_button: Button = %StartGameButton

func _ready() -> void:
	RenderingServer.set_default_clear_color("black")
	start_game_button.grab_focus()

func _on_start_game_button_pressed() -> void:
	GameState.reset_player_lives()
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file(GameState.game_data[GameState.LEVELS.LEVEL_ONE].scene)
	LevelTransition.fade_from_black()

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
