extends ColorRect

@onready var to_start_menu_button: Button = %ToStartMenuButton

func _on_button_pressed() -> void:
	SceneManager.handle_change_scene("res://scenes/ui/menu/start_menu/start_menu.tscn")
