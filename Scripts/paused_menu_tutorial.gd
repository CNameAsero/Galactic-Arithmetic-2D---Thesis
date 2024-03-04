extends Control

@onready var paused = $".."
@onready var gamemanager = $"../../game_manager_world_1-2"

func _on_resume_button_pressed():
	AudioManager.play_button_sfx()
	paused.paused.hide()
	get_tree().paused = false

func _on_restart_button_pressed():
	AudioManager.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/levels/tutorial/tutorial.tscn")
	AudioManager.tuto1_stop()
	AudioManager.tuto2_stop()
	AudioManager.tuto3_stop()
	AudioManager.tuto4_stop()
	AudioManager.tuto5_stop()
	AudioManager.tuto6_stop()
	AudioManager.tuto7_stop()
	paused.paused.hide()
	get_tree().paused = false

func _on_home_button_pressed():
	GameSettings.player_invulnerable = false
	AudioManager.play_button_sfx()
	AudioManager.tuto1_stop()
	AudioManager.tuto2_stop()
	AudioManager.tuto3_stop()
	AudioManager.tuto4_stop()
	AudioManager.tuto5_stop()
	AudioManager.tuto6_stop()
	AudioManager.tuto7_stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")
