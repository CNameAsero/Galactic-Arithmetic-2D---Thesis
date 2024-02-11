extends Control

@onready var levels_sub_menu = $"."

func _ready():
	update_level_locks()

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.tutorialPlayed:
		AudioManager.background_music.stop()
		AudioManager.level1_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/levels/tutorial/tutorial.tscn")
		AudioManager.background_music.stop()

func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[1] == true:
		AudioManager.background_music.stop()
		AudioManager.level1_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
	else:
		print("this is locked")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[2] == true:
		AudioManager.background_music.stop()
		AudioManager.level1_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_3.tscn")
	else:
		print("Clear level 2 to open this level!")

func _on_level_4_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[3] == true:
		AudioManager.background_music.stop()
		AudioManager.level1_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_4.tscn")
	else:
		print("Clear level 3 to open this level!")

func _on_level_5_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[4] == true:
		AudioManager.background_music.stop()
		AudioManager.level1_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_5.tscn")
	else:
		print("Clear level 4 to open this level!")

func update_level_locks():
	if GameSettings.currentlevel[1]:
		$"panel/level2/locked-lvl2".queue_free()
	if GameSettings.currentlevel[2]:
		$"panel/level3/locked-lvl3".queue_free()
	if GameSettings.currentlevel[3]:
		$"panel/level4/locked-lvl4".queue_free()
	if GameSettings.currentlevel[4]:
		$"panel/level5/locked-lvl5".queue_free()

