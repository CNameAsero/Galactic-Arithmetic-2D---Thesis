extends Control

var currentPage = 1

func _ready():
	AudioManager.level3_music.stop()
	audio(currentPage)
#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	audio(currentPage  + 1)
	var nextPage = currentPage + 1
	#the bool storyboardplayed still false just next the page
	if !GameSettings.cutscene3:
		if nextPage <= 7:
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage > 7:
			audio_stop(currentPage)#change this depends on the next you want
			GameSettings.cutscene3 = true
			GameSettings._autosave()
			if GameSettings.currentlevel[15] && GameSettings.cutscene3:
				Loading.load_scene(self, "res://Scenes/Menu/Main_Menu/level_Menu.tscn")
#				get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
				AudioManager.background_music.play()
				AudioManager.level3_music.stop()

func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	GameSettings.cutscene3 = true
	GameSettings._autosave()
	if GameSettings.currentlevel[15] && GameSettings.cutscene3:
		Loading.load_scene(self, "res://Scenes/Menu/Main_Menu/level_Menu.tscn")
#		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
		AudioManager.background_music.play()
		AudioManager.level3_music.stop

func audio(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cuttt" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cuttt" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
