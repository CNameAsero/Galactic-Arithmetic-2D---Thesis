extends Control

var currentPage = 1
@onready var animation_player = $AnimationPlayer

func _ready():
	AudioManager.level4_music.stop()
	audio(currentPage)
	animation_player.play("txtPage" + str(currentPage))

func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)

	if !GameSettings.cutscene4:
		if nextPage <= 7:
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			animation_player.play("txtPage" + str(nextPage))
			currentPage = nextPage
		if nextPage > 7:
			audio_stop(currentPage)
			GameSettings.cutscene4 = true
			GameSettings._autosave()
			if GameSettings.currentlevel[20] && GameSettings.cutscene4:
				get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
				AudioManager.background_music.play()
				AudioManager.level4_music.stop()

func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	GameSettings.cutscene4 = true
	GameSettings._autosave()
	if GameSettings.currentlevel[20] && GameSettings.cutscene4:
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
		AudioManager.background_music.play()
		AudioManager.level4_music.stop()

func audio(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cutttt" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cutttt" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
