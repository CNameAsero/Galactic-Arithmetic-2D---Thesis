extends Control

var currentPage = 1

func _ready():
	AudioManager.level5_music.stop()
	audio(currentPage)

func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)

	if !GameSettings.finalcutscene:
		if nextPage <= 20:
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			currentPage = nextPage
		if nextPage > 20:
			audio_stop(currentPage)
			GameSettings.finalcutscene = true
			GameSettings._autosave()
			get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")


func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	GameSettings.finalcutscene = true
	GameSettings._autosave()
	get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/main_menu.tscn")


func audio(num):
	if num >= 1 and num <= 20:
		var playvoiceover = "final_cut" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 20:
		var playvoiceover = "final_cut" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
