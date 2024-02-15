extends Control

var currentPage = 1
var storyboardPlayed = false

func _ready():
	audio(currentPage)
#storyboard next if tap the screen
func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)
	#the bool storyboardplayed still false just next the page
	if not get_node("/root/GameSettings").storyboardPlayed:
		if nextPage <= 18:  # Change this to 18
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage > 18:  # Change this to 18
			AudioManager.background_music.play()
			audio_stop(currentPage)
			Loading.load_scene(self, "res://Scenes/Menu/Main_Menu/level_Menu.tscn")
#			get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
			get_node("/root/GameSettings").storyboardPlayed = true
			GameSettings._autosave()

func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	AudioManager.background_music.play()
	Loading.load_scene(self, "res://Scenes/Menu/Main_Menu/level_Menu.tscn")
#	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
	get_node("/root/GameSettings").storyboardPlayed = true
	GameSettings._autosave()

func audio(num):
	if num >= 1 and num <= 18:  # Change this to 18
		var playvoiceover = "sto" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 18:  # Change this to 18
		var playvoiceover = "sto" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
