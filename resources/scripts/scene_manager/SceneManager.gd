extends Node

func handle_change_scene(selected_scene: String) -> void: 
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file(selected_scene)
	LevelTransition.fade_from_black()
