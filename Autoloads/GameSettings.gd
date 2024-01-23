extends Node

@onready var storyboardPlayed = false
@onready var tutorialPlayed = false

#this is to check whether the player is all done in the grass
@onready var currentlevel = [true, false, false, false, false]

#for level to proceed to next
var current_level = 1

#this is to check what level the player in the grass area
@onready var grasscurrentlevel = [true, false, false]
@onready var watercurrentlevel = [true, false, false]
@onready var lavacurrentlevel = [true, false, false]
@onready var icecurrentlevel = [true, false, false]
@onready var roofcurrentlevel = [true, false, false]
