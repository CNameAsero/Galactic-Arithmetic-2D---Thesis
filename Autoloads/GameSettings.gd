extends Node

@onready var storyboardPlayed = false
@onready var tutorialPlayed = false

#for level to proceed to next
var current_level = 0
var max_unlocked_level = 0

#this is to check what level the player in the grass area
@onready var currentlevel = [true, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false]



