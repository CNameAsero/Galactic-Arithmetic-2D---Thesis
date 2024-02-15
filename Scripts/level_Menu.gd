extends Control

var current_area = 0
@onready var world1 = $Level_Menu_Bg/Picture_Border_Level/world1_area
@onready var world2 = $Level_Menu_Bg/Picture_Border_Level/world2_area
@onready var world3 = $Level_Menu_Bg/Picture_Border_Level/world3_area
@onready var world4 = $Level_Menu_Bg/Picture_Border_Level/world4_area
@onready var world5 = $Level_Menu_Bg/Picture_Border_Level/world5_area
@onready var areas = [world1, world2, world3, world4, world5]

@onready var grass_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world1_area/levels_sub_menu
@onready var ocean_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world2_area/levels_sub_menu_ocean
@onready var lava_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world3_area/levels_sub_menu_lava
@onready var ice_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world4_area/levels_sub_menu_ice
@onready var city_sub_menu = $Level_Menu_Bg/Picture_Border_Level/world5_area/levels_sub_menu_city#change scene to level menu
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
	grass_sub_menu.show()

func _on_world_2_area_pressed():
	AudioManager.play_button_sfx()
	ocean_sub_menu.show()


func _on_world_3_area_pressed():
	AudioManager.play_button_sfx()
	lava_sub_menu.show()


func _on_world_4_area_pressed():
	AudioManager.play_button_sfx()
	ice_sub_menu.show()


func _on_world_5_area_pressed():
	AudioManager.play_button_sfx()
	city_sub_menu.show()

func _process(_delta):
	if GameSettings.currentlevel[5]:
		$Level_Menu_Bg/Picture_Border_Level/world2_area/locked.hide()
	if GameSettings.currentlevel[10]:
		$Level_Menu_Bg/Picture_Border_Level/world3_area/locked.hide()
	if GameSettings.currentlevel[15]:
		$Level_Menu_Bg/Picture_Border_Level/world4_area/locked.hide()
	if GameSettings.currentlevel[20]:
		$Level_Menu_Bg/Picture_Border_Level/world5_area/locked.hide()

	if $Level_Menu_Bg/Picture_Border_Level/world1_area.visible:
		$Level_Menu_Bg/Picture_Border_Level/w1_text.show()
	else:
		$Level_Menu_Bg/Picture_Border_Level/w1_text.hide()
	if $Level_Menu_Bg/Picture_Border_Level/world2_area.visible:
		$Level_Menu_Bg/Picture_Border_Level/w2_text.show()
	else:
		$Level_Menu_Bg/Picture_Border_Level/w2_text.hide()
	if $Level_Menu_Bg/Picture_Border_Level/world3_area.visible:
		$Level_Menu_Bg/Picture_Border_Level/w3_text.show()
	else:
		$Level_Menu_Bg/Picture_Border_Level/w3_text.hide()
	if $Level_Menu_Bg/Picture_Border_Level/world4_area.visible:
		$Level_Menu_Bg/Picture_Border_Level/w4_text.show()
	else:
		$Level_Menu_Bg/Picture_Border_Level/w4_text.hide()
	if $Level_Menu_Bg/Picture_Border_Level/world5_area.visible:
		$Level_Menu_Bg/Picture_Border_Level/w5_text.show()
	else:
		$Level_Menu_Bg/Picture_Border_Level/w5_text.hide()
