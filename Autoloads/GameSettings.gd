extends Node

var player_invulnerable = false

@onready var storyboardPlayed = false
@onready var cutscene1 = false
@onready var cutscene2 = false
@onready var cutscene3 = false
@onready var cutscene4 = false
@onready var finalcutscene = false
@onready var tutorialPlayed = false

@onready var isHard = false

@onready var isTuto1 = false
@onready var isTuto2 = false
@onready var isTuto3 = false
@onready var isTuto4 = false
@onready var isTuto5 = false

#for level to proceed to next
var current_world = 0
var current_level = 0
var max_unlocked_level = 0

#this is to check what level the player in the grass area
@onready var currentlevel = [true, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, false]

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
		"currentlevels:": currentlevel
	}

