extends Control

@onready var levels_sub_menu = $"."

func _ready():
	update_level_locks()

func _on_exit_button_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.hide()

func _on_level_1_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.cutscene1 && GameSettings.currentlevel[5]:
		GameSettings.isHard = false
		AudioManager.background_music.stop()
		AudioManager.level2_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_6.tscn", "res://Scenes/levels/level_6_1.tscn", "res://Scenes/levels/level_6_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else: 
		AudioManager.background_music.stop()
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/cut_scene_1.tscn")

func _on_level_2_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[6] == true:
		GameSettings.isHard = false
		AudioManager.background_music.stop()
		AudioManager.level2_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_7.tscn", "res://Scenes/levels/level_7_1.tscn", "res://Scenes/levels/level_7_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 6 to open this level!")

func _on_level_3_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[7] == true:
		GameSettings.isHard = false
		AudioManager.background_music.stop()
		AudioManager.level2_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_8.tscn", "res://Scenes/levels/level_8_1.tscn", "res://Scenes/levels/level_8_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 7 to open this level!")

func _on_level_4_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[8] == true:
		GameSettings.isHard = false
		AudioManager.background_music.stop()
		AudioManager.level2_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_9.tscn", "res://Scenes/levels/level_9_1.tscn", "res://Scenes/levels/level_9_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 8 to open this level!")

func _on_level_5_pressed():
	AudioManager.play_button_sfx()
	if GameSettings.currentlevel[9] == true:
		GameSettings.isHard = false
		AudioManager.background_music.stop()
		AudioManager.level2_music.play()
		GameSettings._autosave()
		var rng = RandomNumberGenerator.new()
		var scenes = []
		scenes = ["res://Scenes/levels/level_10.tscn", "res://Scenes/levels/level_10_1.tscn", "res://Scenes/levels/level_10_2.tscn"]
		var random_index = rng.randi_range(0, scenes.size() - 1)
		var random_scene = scenes[random_index]
		get_tree().change_scene_to_file(random_scene)
	else:
		print("Clear level 9 to open this level!")

func update_level_locks():
	if GameSettings.currentlevel[6]:
		$"panel/level2/locked-lvl2".queue_free()
	if GameSettings.currentlevel[7]:
		$"panel/level3/locked-lvl3".queue_free()
	if GameSettings.currentlevel[8]:
		$"panel/level4/locked-lvl4".queue_free()
	if GameSettings.currentlevel[9]:
		$"panel/level5/locked-lvl5".queue_free()

