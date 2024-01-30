extends Control

@onready var levels_sub_menu = $"."

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	AudioManager.background_music.stop()
	AudioManager.level1_music.play()
	if GameSettings.tutorialPlayed:
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/levels/tutorial/tutorial.tscn")

func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.grasscurrentlevel[1]==true:
		get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
	else:
		print("this is locked")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.grasscurrentlevel[2]:
		pass
	else:
		print("Clear level 2 to open this level!")

func _ready():
	update_level_locks()

func update_level_locks():
	if GameSettings.grasscurrentlevel[1]:
		$"panel/level2/locked-lvl2".hide()
	if GameSettings.grasscurrentlevel[2]:
		$"panel/level3/locked-lvl3".hide()
