extends Node

const save_path = "res://savefile.save"

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
	var config = ConfigFile.new()
	
	config.set_value("game_data", "storyboard_played?", storyboardPlayed)
	config.set_value("game_data", "1sttutorial_played?", tutorialPlayed)
	config.set_value("game_data", "cutscene1?", cutscene1)
	config.set_value("game_data", "cutscene2?", cutscene2)
	config.set_value("game_data", "cutscene3?", cutscene3)
	config.set_value("game_data", "cutscene4?", cutscene4)
	config.set_value("game_data", "finalscene?", finalcutscene)
	config.set_value("game_data", "isHard?", isHard)
	config.set_value("game_data", "tuto1?", isTuto1)
	config.set_value("game_data", "tuto2?", isTuto2)
	config.set_value("game_data", "tuto3?", isTuto3)
	config.set_value("game_data", "tuto4?", isTuto4)
	config.set_value("game_data", "tuto5?", isTuto5)
	config.set_value("game_data", "currentworld?", current_world)
	config.set_value("game_data", "maxunlocked_level?", max_unlocked_level)
	config.set_value("game_data", "currentlevels?", currentlevel)
	config.set_value("game_data", "music_volume?", music_volume)
	config.set_value("game_data", "sfx_volume?", sfx_volume)
	config.set_value("game_data", "world_completed?", world_completed)
	
	var error = config.save("res://GameSettings.cfg")

	if error != OK:
		print("Failed to save game settings.")


func _autoload():
	var config = ConfigFile.new()
	var error = config.load("res://GameSettings.cfg")

	if error != OK:
		print("Failed to load game settings.")
		return

	storyboardPlayed = config.get_value("game_data", "storyboard_played?", false)
	tutorialPlayed = config.get_value("game_data", "1sttutorial_played?", false)
	cutscene1 = config.get_value("game_data", "cutscene1?", false)
	cutscene2 = config.get_value("game_data", "cutscene2?", false)
	cutscene3 = config.get_value("game_data", "cutscene3?", false)
	cutscene4 = config.get_value("game_data", "cutscene4?", false)
	finalcutscene = config.get_value("game_data", "finalscene?", false)
	isHard = config.get_value("game_data", "isHard?", false)
	isTuto1 = config.get_value("game_data", "tuto1?", false)
	isTuto2 = config.get_value("game_data", "tuto2?", false)
	isTuto3 = config.get_value("game_data", "tuto3?", false)
	isTuto4 = config.get_value("game_data", "tuto4?", false)
	isTuto5 = config.get_value("game_data", "tuto5?", false)
	current_world = config.get_value("game_data", "currentworld?", 0)
	max_unlocked_level = config.get_value("game_data", "maxunlocked_level?", 0)
	currentlevel = config.get_value("game_data", "currentlevels?", [])
	music_volume = config.get_value("game_data", "music_volume?", -10)
	sfx_volume = config.get_value("game_data", "sfx_volume?", -10)
	world_completed = config.get_value("game_data", "world_completed?", {})

