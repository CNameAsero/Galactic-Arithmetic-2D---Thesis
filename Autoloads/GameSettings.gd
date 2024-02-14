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
		"maxunlocked_level": max_unlocked_level,
		"currentlevels:": currentlevel,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"world_completed?": world_completed
	}

