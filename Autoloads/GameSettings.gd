extends Node

var player_invulnerable = false

var world_completed = {}

@onready var storyboardPlayed = false #ok
@onready var cutscene1 = false #ok
@onready var cutscene2 = false #ok
@onready var cutscene3 = false #ok
@onready var cutscene4 = false #ok
@onready var finalcutscene = false #ok
@onready var tutorialPlayed = false #ok

@onready var isHard = false #ok

@onready var isTuto1 = false #ok
@onready var isTuto2 = false #ok
@onready var isTuto3 = false #ok
@onready var isTuto4 = false #ok
@onready var isTuto5 = false #ok

#for level to proceed to next
var current_world = 0 #ok
var current_level = 0
var max_unlocked_level = 0 #ok

#this is to check what level the player in the grass area
@onready var currentlevel = [true, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, false] #ok

var music_volume = -10#ok
var sfx_volume = -10 #ok

func _autosave():
	var save_data = {
		"storyboard_played?": storyboardPlayed,
		"1sttutorial_played?": tutorialPlayed,
		"cutscene1?": cutscene1,
		"cutscene2?": cutscene2,
		"cutscene3?": cutscene3,
		"cutscene4?": cutscene4,
		"finalscene?": finalcutscene,
		"isHard?": isHard,
		"tuto1?": isTuto1,
		"tuto2?": isTuto2,
		"tuto3?": isTuto3,
		"tuto4?": isTuto4,
		"tuto5?": isTuto5,
		"currentworld?": current_world,
		"maxunlocked_level?": max_unlocked_level,
		"currentlevels?": currentlevel,
		"music_volume?": music_volume,
		"sfx_volume?": sfx_volume,
		"world_completed?": world_completed
	}
	
	var save_game = GameSave.new()
	save_game.set_data(save_data)
	
	ResourceSaver.save(save_game,"res://savegame.tres")

func _autoload():
	var loaded_game_save = ResourceLoader.load("res://savegame.tres") 
	
	if loaded_game_save != null:
		var loaded_data = loaded_game_save.get_data()  # Get the data from the GameSave instance

		storyboardPlayed = loaded_data["storyboard_played?"]
		tutorialPlayed = loaded_data["1sttutorial_played?"]
		cutscene1 = loaded_data["cutscene1?"]
		cutscene2 = loaded_data["cutscene2?"]
		cutscene3 = loaded_data["cutscene3?"]
		cutscene4 = loaded_data["cutscene4?"]
		finalcutscene = loaded_data["finalscene?"]
		isHard = loaded_data["isHard?"]
		isTuto1 = loaded_data["tuto1?"]
		isTuto2 = loaded_data["tuto2?"]
		isTuto3 = loaded_data["tuto3?"]
		isTuto4 = loaded_data["tuto4?"]
		isTuto5 = loaded_data["tuto5?"]
		current_world = loaded_data["currentworld?"]
		max_unlocked_level = loaded_data["maxunlocked_level?"]
		currentlevel = loaded_data["currentlevels?"]
		music_volume = loaded_data ["music_volume?"]
		sfx_volume = loaded_data ["sfx_volume?"]
		world_completed = loaded_data["world_completed?"]
