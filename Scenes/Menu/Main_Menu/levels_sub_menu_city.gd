extends Control

@onready var levels_sub_menu = $"."

func _ready():
	update_level_locks()

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.cutscene4 && GameSettings.currentlevel[20]:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level5_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_21.tscn", "res://Scenes/levels/level_21_1.tscn", "res://Scenes/levels/level_21_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else: 
		AudioManager.background_music.stop()
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/cut_scene_4.tscn")

func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[21] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level5_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_22.tscn", "res://Scenes/levels/level_22_1.tscn", "res://Scenes/levels/level_22_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 21 to open this level!")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[22] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level5_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_23.tscn", "res://Scenes/levels/level_23_1.tscn", "res://Scenes/levels/level_23_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 22 to open this level!")

func _on_level_4_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[23] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level5_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_24.tscn", "res://Scenes/levels/level_24_1.tscn", "res://Scenes/levels/level_24_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 23 to open this level!")

func _on_level_5_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[24] == true:
		GameSettings.isHard = true
		AudioManager.background_music.stop()
		AudioManager.level5_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_25.tscn", "res://Scenes/levels/level_25_1.tscn", "res://Scenes/levels/level_25_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 24 to open this level!")

func update_level_locks():
	if GameSettings.currentlevel[21]:
		$"panel/level2/locked-lvl2".queue_free()
	if GameSettings.currentlevel[22]:
		$"panel/level3/locked-lvl3".queue_free()
	if GameSettings.currentlevel[23]:
		$"panel/level4/locked-lvl4".queue_free()
	if GameSettings.currentlevel[24]:
		$"panel/level5/locked-lvl5".queue_free()

