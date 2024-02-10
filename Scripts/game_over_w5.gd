extends Control

@onready var game_manager = $"../../gamemanager_algebra"

func _on_restart_button_pressed():
	game_manager.restart()
	AudioManager.play_button_sfx()
	get_tree().paused = false

func _on_home_button_pressed():
	game_manager.reset_hp()
	AudioManager.play_button_sfx()
	AudioManager.level1_music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")
