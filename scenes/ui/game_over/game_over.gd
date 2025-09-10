extends ColorRect

@onready var to_start_menu_button: Button = %ToStartMenuButton

func _on_button_pressed() -> void:
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/ui/menu/start_menu/start_menu.tscn")
	LevelTransition.fade_from_black()
