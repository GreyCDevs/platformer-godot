extends Node2D

@onready var level_completed: ColorRect = $CanvasLayer/LevelCompleted
@onready var game_over: ColorRect = $CanvasLayer/GameOver

@onready var collectibles: Node = $Collectibles

@onready var start_in: ColorRect = %StartIn
@onready var start_in_label: Label = %StartInLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var best_time_container: ColorRect = $CanvasLayer/BestTimeContainer
@onready var best_time_label: Label = %BestTimeLabel
@onready var timer_container: ColorRect = $CanvasLayer/TimerContainer
@onready var timer_label: Label = %TimerLabel
@onready var time_count: Timer = $CanvasLayer/TimeCount

@onready var life_counter_label: Label = %LifeCounterLabel
@onready var collectibles_counter_label_label: Label = %CollectiblesCounterLabelLabel

var time_passed: int = 0
var sardines_in_level: int
var sardines_taken: int = 0


func _ready() -> void:
	Events.level_completed.connect(show_level_completed)
	Events.game_over.connect(show_game_over)
	Events.sardine_taken.connect(handle_sardine_taken)
	Events.life_lost.connect(handle_life_lost)
	
	sardines_in_level = collectibles.get_child_count()
	life_counter_label.text = "%1d/%1d" % [GameState.player_lives, GameState.MAX_PLAYER_LIVES]
	collectibles_counter_label_label.text = "%d/%d" % [0, sardines_in_level]
	
	handle_level_record()
	
	get_tree().paused = true
	animation_player.play("countdown")
	await get_tree().create_timer(3.0).timeout
	start_in_label.hide()
	get_tree().paused = false
	animation_player.play("hide_start_label")
	if animation_player.animation_finished:
		start_in.hide()
	
	
func show_level_completed() -> void:
	level_completed.show()
	time_count.stop()
	
	var next_level = GameState.handle_finished_level(GameState.current_level, time_passed)

	if next_level == null: 
		get_tree().change_scene_to_file("res://scenes/ui/game_finished/game_finished.tscn")
		return
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(next_level.scene)
	LevelTransition.fade_from_black()

func show_game_over() -> void:
	timer_container.hide()
	time_count.stop()
	game_over.show()
	game_over.to_start_menu_button.grab_focus()

func handle_life_lost() -> void:
	life_counter_label.text = "%1d/%1d" % [GameState.player_lives, GameState.MAX_PLAYER_LIVES]

func handle_sardine_taken() -> void:
	sardines_taken += 1
	collectibles_counter_label_label.text = "%d/%d" % [sardines_taken, sardines_in_level]

func handle_level_record () -> void:
	if not GameState.does_current_level_have_record(): return
	var current_level_record = GameState.get_current_level_record()
	var minutes = int(current_level_record / 60)
	var seconds = current_level_record - minutes * 60
	
	best_time_label.text = "Record: %d:%02d" % [minutes, seconds]
	best_time_container.show()
	pass

func _on_timer_timeout() -> void:
	time_passed += 1
	var minutes = int(time_passed / 60)
	var seconds = time_passed - minutes * 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]
