extends Control

var currentPage = 2
var storyboardPlayed = false


func _ready():
	audio(currentPage)

#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage)
	#the bool storyboardplayed still false just next the page
	if not get_node("/root/GameSettings").storyboardPlayed:
		if nextPage <= 17:
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage >= 18:
			audio_stop(currentPage)
			get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
			get_node("/root/GameSettings").storyboardPlayed = true

func _on_skip_pressed():
	AudioManager.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
	get_node("/root/GameSettings").storyboardPlayed = true

func audio(num):
	if num >= 1 and num <= 17:
		var playvoiceover = "sto" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 17:
		var playvoiceover = "sto" + str(num) + "_stop"
		AudioManager.call(playvoiceover)


