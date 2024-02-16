extends Control

@onready var levels_sub_menu = $"."

func _ready():
	update_level_locks()

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.cutscene2 && GameSettings.currentlevel[10]:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level3_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_11.tscn", "res://Scenes/levels/level_11_1.tscn", "res://Scenes/levels/level_11_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else: 
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/cut_scene_2.tscn")

func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[11] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level3_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_12.tscn", "res://Scenes/levels/level_12_1.tscn", "res://Scenes/levels/level_12_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 11 to open this level!")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[12] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level3_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_13.tscn", "res://Scenes/levels/level_13_1.tscn", "res://Scenes/levels/level_13_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 12 to open this level!")

func _on_level_4_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[13] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level3_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_14.tscn", "res://Scenes/levels/level_14_1.tscn", "res://Scenes/levels/level_14_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 13 to open this level!")

func _on_level_5_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[14] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level3_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_15.tscn", "res://Scenes/levels/level_15_1.tscn", "res://Scenes/levels/level_15_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 14 to open this level!")

func update_level_locks():
	if GameSettings.currentlevel[11]:
		$"panel/level2/locked-lvl2".queue_free()
	if GameSettings.currentlevel[12]:
		$"panel/level3/locked-lvl3".queue_free()
	if GameSettings.currentlevel[13]:
		$"panel/level4/locked-lvl4".queue_free()
	if GameSettings.currentlevel[14]:
		$"panel/level5/locked-lvl5".queue_free()

