extends Control
class_name game_paused

@onready var paused = $".."
@onready var gamemanager = $"../../game_manager_world_1-2"

func _on_resume_button_pressed():
	AudioManager.play_button_sfx()
	paused.paused.hide()
	get_tree().paused = false

func _on_restart_button_pressed():
	AudioManager.play_button_sfx()
	gamemanager.restart()
	paused.paused.hide()
	get_tree().paused = false

func _on_home_button_pressed():
	AudioManager.play_button_sfx()
	AudioManager.level1_music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")
