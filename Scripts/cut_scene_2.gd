extends Control

var currentPage = 1
@onready var animation_player = $AnimationPlayer

func _ready():
	AudioManager.level2_music.stop()
	audio(currentPage)
	animation_player.play("txtPage" + str(currentPage))

func _on_tap_to_continue_pressed():
	AudioManager.play_button_sfx()
	var nextPage = currentPage + 1
	audio(currentPage  + 1)

	if !GameSettings.cutscene2:
		if nextPage <= 7:
			audio(currentPage + 1)
			audio_stop(currentPage)
			get_node("Page" + str(currentPage)).hide()
			get_node("Page" + str(nextPage)).show()
			animation_player.play("txtPage" + str(nextPage))
			currentPage = nextPage
		if nextPage > 7:
			audio_stop(currentPage)
			GameSettings.cutscene2 = true
			GameSettings.isHard = true
			GameSettings._autosave()
			if GameSettings.currentlevel[10] && GameSettings.cutscene2:
				get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
				AudioManager.background_music.play()
				AudioManager.level2_music.stop()

func _on_skip_pressed():
	audio_stop(currentPage)
	AudioManager.play_button_sfx()
	GameSettings.cutscene2 = true
	GameSettings.isHard = true
	GameSettings._autosave()
	if GameSettings.currentlevel[10] && GameSettings.cutscene2:
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
		AudioManager.background_music.play()
		AudioManager.level2_music.stop()

func audio(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cutt" + str(num)
		AudioManager.call(playvoiceover)

func audio_stop(num):
	if num >= 1 and num <= 7:
		var playvoiceover = "cutt" + str(num) + "_stop"
		AudioManager.call(playvoiceover)
