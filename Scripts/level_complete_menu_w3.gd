extends Control

@onready var label = $bg/timer/Label
@onready var timer = $"../../gamemanager_pemdas/timer"
@onready var game_manager = $"../../gamemanager_pemdas"

func _on_next_level_button_pressed():
	AudioManager.play_button_sfx()
	GameSettings.current_level += 1
	
	var next_scene_path = "res://Scenes/levels/level_" + str(GameSettings.current_level) + ".tscn"
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("Level " + str(GameSettings.current_level) + " does not exist.")
	
	get_tree().paused = false

func _on_restart_button_pressed():
	AudioManager.play_button_sfx()
	get_tree().paused = false
	game_manager.restart()
