extends Control

var currentPage = 2
var storyboardPlayed = false
#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	#the bool storyboardplayed still false just next the page
	if not get_node("/root/GameSettings").storyboardPlayed:
		if nextPage <= 17:
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
	#then if all the page flash in the screen then go to level menu
		if nextPage >= 18:
			get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
			get_node("/root/GameSettings").storyboardPlayed = true

func _on_skip_pressed():
	AudioManager.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
	get_node("/root/GameSettings").storyboardPlayed = true
