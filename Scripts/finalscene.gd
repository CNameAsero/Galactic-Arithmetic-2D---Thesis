extends Control

var currentPage = 1

func _ready():
	AudioManager.level5_music.stop()
	audio(currentPage)
#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)
	#the bool storyboardplayed still false just next the page
	if !GameSettings.finalcutscene:
		if nextPage <= 20:  # Change this to 18
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage > 20:  # Change this to 18
			audio_stop(currentPage)
			get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn") #change this depends on the next you want
			GameSettings.finalcutscene = true

func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")  #change this depends on the next you want
	GameSettings.finalcutscene = true

func audio(num):
	if num >= 1 and num <= 20:  # Change this to 18
		var playvoiceover = "final_cut" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 20:  # Change this to 18
		var playvoiceover = "final_cut" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
