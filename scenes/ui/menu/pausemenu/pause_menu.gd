extends Control

@onready var pause_menu = $"."
@onready var resume_button = %ResumeButton

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color("black")
	

func _on_resume_button_pressed():
	pause_menu.hide()
	get_tree().paused = false  


func _on_quit_to_main_menu_button_pressed():
	GameState.reset_player_lives()
	await LevelTransition.fade_to_black() 
	LevelTransition.fade_from_black()
	get_tree().change_scene_to_file("res://scenes/ui/menu/start_menu/start_menu.tscn")
