extends ColorRect

@onready var score_board_container: VBoxContainer = %ScoreBoardContainer

@onready var go_back_button: Button = %GoBackButton

func _ready() -> void:
	go_back_button.grab_focus()
	var game_data = GameState.game_data
	for level in game_data:
		var level_data = game_data[level]
		if level_data.score_board.size() <= 0:
			continue
		
		var game_level_name_label = Label.new()
		game_level_name_label.set_name("label-for-" + level_data.name)
		game_level_name_label.text = "Level name: " + level_data.name
	
		var separator_label = Label.new()
		separator_label.set_name("separator-label-for-" + level_data.name)
		separator_label.text = "------"
		
		var score_board = level_data.score_board
		score_board = score_board.filter(func (a): return a != null)
		score_board.sort_custom(func(a, b): return a.time < b.time)
		score_board.resize(3)
		score_board = score_board.filter(func (a): return a != null)
		
		
		score_board_container.add_child(game_level_name_label)
		score_board_container.add_child(separator_label)
		for score in score_board:
			if score == null:
				continue
			var score_label = Label.new()
			var minutes = int(score.time / 60)
			var seconds = score.time - minutes * 60
			var score_separator_label = Label.new()
			score_separator_label.set_name("separator-label-for-" + level_data.name)
			score_separator_label.text = "------"
			score_label.set_name("score-label-for-" + score.name)
			score_label.text = score.name + ": %d:%02d" % [minutes, seconds]
			score_board_container.add_child(score_label)
			score_board_container.add_child(score_separator_label)
			

func _on_button_pressed() -> void:
	if GameState.back_from_score_board == null: return
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file(GameState.back_from_score_board)
	LevelTransition.fade_from_black()
