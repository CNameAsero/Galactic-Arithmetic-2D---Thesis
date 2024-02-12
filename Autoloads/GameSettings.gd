extends Node

var player_invulnerable = false

@onready var storyboardPlayed = false
@onready var cutscene1 = false
@onready var cutscene2 = false
@onready var cutscene3 = false
@onready var cutscene4 = false
@onready var finalcutscene = false

@onready var tutorialPlayed = false

#for level to proceed to next
var current_world = 0
var current_level = 0
var max_unlocked_level = 0

#this is to check what level the player in the grass area
@onready var currentlevel = [true, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false]



