extends Control

@onready var label = $bg/timer/Label
@onready var timer = $"../../gamemanager_fraction/timer"
@onready var game_manager = $"../../gamemanager_fraction"

func _on_next_level_button_pressed():
	AudioManager.play_button_sfx()
	var cut_scene_path = "res://Scenes/Menu/Main_Menu/cut_scene_" + str(GameSettings.current_world) + ".tscn"
	var next_scene_path = "res://Scenes/levels/level_" + str(GameSettings.current_level+1) + ".tscn"
	if GameSettings.current_level % 5 == 0:
		if ResourceLoader.exists(cut_scene_path):
			AudioManager.level4_music.stop()
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
