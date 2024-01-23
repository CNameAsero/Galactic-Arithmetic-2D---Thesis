extends Control

var current_area = 0
@onready var world1 = $Level_Menu_Bg/Picture_Border_Level/world1_area
@onready var world2 = $Level_Menu_Bg/Picture_Border_Level/world2_area
@onready var world3 = $Level_Menu_Bg/Picture_Border_Level/world3_area
@onready var world4 = $Level_Menu_Bg/Picture_Border_Level/world4_area
@onready var world5 = $Level_Menu_Bg/Picture_Border_Level/world5_area
@onready var areas = [world1, world2, world3, world4, world5]

@onready var levels_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world1_area/levels_sub_menu


#change scene to level menu
func _on_back_button_level_menu_pressed():
	AudioManager.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")

func _on_right_button_pressed():
	AudioManager.play_button_sfx()
	areas[current_area].hide()
	current_area = current_area + 1
	if current_area < 5:
		areas[current_area].show()
	else:
		current_area = 4
		areas[4].show()

func _on_left_button_pressed():
	AudioManager.play_button_sfx()
	areas[current_area].hide()
	current_area = current_area - 1
	if current_area >= 0:
		areas[current_area].show()
	else:
		current_area = 0
		areas[0].show()

func _on_world_1_area_pressed():
	AudioManager.play_button_sfx()
	levels_sub_menu.show()

func _on_world_2_area_pressed():
	pass # Replace with function body.


func _on_world_3_area_pressed():
	pass # Replace with function body.


func _on_world_4_area_pressed():
	pass # Replace with function body.


func _on_world_5_area_pressed():
	pass # Replace with function body.



