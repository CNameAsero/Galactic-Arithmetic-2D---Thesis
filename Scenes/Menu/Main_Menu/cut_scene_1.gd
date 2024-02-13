extends Control

var currentPage = 1

func _ready():
	AudioManager.level1_music.stop()
	audio(currentPage)
#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)
	#the bool storyboardplayed still false just next the page
	if !GameSettings.cutscene1:
		if nextPage <= 7:  # Change this to 18
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage > 7:  # Change this to 18
			audio_stop(currentPage)
			GameSettings.cutscene1 = true
			if GameSettings.currentlevel[5] && GameSettings.cutscene1:
				get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
				AudioManager.background_music.play()
				AudioManager.level1_music.stop()


func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	GameSettings.cutscene1 = true
	if GameSettings.currentlevel[5] && GameSettings.cutscene1:
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
		AudioManager.background_music.play()
		AudioManager.level1_music.stop()


func audio(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cut" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cut" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
