extends CenterContainer

@onready var button: Button = $PlayerNameSelection/Button
@onready var line_edit: LineEdit = $PlayerNameSelection/LineEdit

func _ready() -> void:
	line_edit.grab_focus()

func handle_start_game() -> void:
	GameState.reset_player_lives()
	await LevelTransition.fade_to_black()
	GameState.current_level = GameState.INITIAL_LEVEL
	get_tree().change_scene_to_file(GameState.game_data[GameState.INITIAL_LEVEL].scene)
	LevelTransition.fade_from_black()

func handle_change_name(new_text: String) -> void:
	var player_name = new_text.strip_edges()
	if not player_name.length(): 
		button.disabled = true
		return
	GameState.set_player_name(player_name)
	button.disabled = false

func _on_button_pressed() -> void:
	handle_start_game()

func _on_line_edit_text_submitted(new_text: String) -> void:
	handle_change_name(new_text)
	if not button.disabled:
		handle_start_game()

func _on_line_edit_text_changed(new_text: String) -> void:
	handle_change_name(new_text)
	
