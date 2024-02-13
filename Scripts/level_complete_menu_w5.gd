extends Control

@onready var label = $bg/timer/Label
@onready var timer = $"../../gamemanager_algebra/timer"
@onready var game_manager = $"../../gamemanager_algebra"

func _on_next_level_button_pressed():
	AudioManager.play_button_sfx()
	var cut_scene_path = "res://Scenes/Menu/Main_Menu/finalscene.tscn"
	var next_scene_path = "res://Scenes/levels/level_" + str(GameSettings.current_level+1) + ".tscn"
	if GameSettings.current_level % 25 == 0 && GameSettings.current_world == 5:
		if ResourceLoader.exists(cut_scene_path):
			AudioManager.level5_music.stop()
			get_tree().change_scene_to_file(cut_scene_path)
	else:
		if ResourceLoader.exists(next_scene_path):
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("Level " + str(GameSettings.current_level) + " does not exist.")

	get_tree().paused = false

func _on_restart_button_pressed():
	AudioManager.play_button_sfx()
	get_tree().paused = false
	game_manager.restart()
