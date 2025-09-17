extends Node

func handle_change_scene(selected_scene: String) -> void: 
	handle_change_button_disabled_status(true)
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file(selected_scene)
	LevelTransition.fade_from_black()

func handle_change_button_disabled_status(is_disabled: bool) -> void:
	var buttons = get_tree().get_nodes_in_group("Buttons")
	if not buttons.size(): return
	
	for button in buttons: 
		button.disabled = is_disabled
