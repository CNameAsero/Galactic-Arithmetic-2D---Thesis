extends Control

@onready var levels_sub_menu = $"."

func _ready():
	update_level_locks()

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.cutscene3 || GameSettings.currentlevel[15]:
		AudioManager.background_music.stop()
		AudioManager.level4_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_16.tscn")
	else: 
		AudioManager.background_music.stop()
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/cut_scene_3.tscn")


func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[16] == true:
		AudioManager.background_music.stop()
		AudioManager.level4_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_17.tscn")
	else:
		print("Clear level 16 to open this level!")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[17] == true:
		AudioManager.background_music.stop()
		AudioManager.level4_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_18.tscn")
	else:
		print("Clear level 17 to open this level!")

func _on_level_4_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[18] == true:
		AudioManager.background_music.stop()
		AudioManager.level4_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_19.tscn")
	else:
		print("Clear level 18 to open this level!")

func _on_level_5_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[19] == true:
		AudioManager.background_music.stop()
		AudioManager.level4_music.play()
		get_tree().change_scene_to_file("res://Scenes/levels/level_20.tscn")
	else:
		print("Clear level 19 to open this level!")

func update_level_locks():
	if GameSettings.currentlevel[16]:
		$"panel/level2/locked-lvl2".queue_free()
	if GameSettings.currentlevel[17]:
		$"panel/level3/locked-lvl3".queue_free()
	if GameSettings.currentlevel[18]:
		$"panel/level4/locked-lvl4".queue_free()
	if GameSettings.currentlevel[19]:
		$"panel/level5/locked-lvl5".queue_free()

