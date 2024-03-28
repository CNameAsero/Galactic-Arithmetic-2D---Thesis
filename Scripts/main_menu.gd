extends Control

func _ready():
	GameSettings._autoload()
	AudioManager.background_music.play()
	$Option_Menu_Bg/Inside_BG/music_slider.value = GameSettings.music_volume
	$Option_Menu_Bg/Inside_BG/sfx_slider.value = GameSettings.sfx_volume

#change scene to story or level menu
func _on_play_button_pressed():
	AudioManager.play_button_sfx()
	#here if the storyboard still not played then do this
	if not get_node("/root/GameSettings").storyboardPlayed:
		AudioManager.background_music.stop()
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/story_board(cut_scene).tscn")
	#if the storyboard already play then just go to level menu
	else:
		get_tree().change_scene_to_file("res://Scenes/Menu/Main_Menu/level_Menu.tscn")
		AudioManager.background_music.play()

#here if click the option button then just hide the main menu and show option menu
func _on_option_button_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg.hide()
	$Option_Menu_Bg.show()

#quit game
func _on_exit_pressed():
	AudioManager.play_button_sfx()
	get_tree().quit()

#this is the back button in the optionmenu just hide the option and show the menu
func _on_back_button_option_menu_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg.show()
	$Option_Menu_Bg.hide()
#music toggle button in settings

func _on_music_slider_value_changed(value) -> void:
	GameSettings.music_volume = value
	AudioServer.set_bus_volume_db(AudioManager.Music_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(AudioManager.Music_bus, true)
	else:
		AudioServer.set_bus_mute(AudioManager.Music_bus, false)
	GameSettings._autosave()

func _on_sfx_slider_value_changed(value) -> void:
	GameSettings.sfx_volume = value
	AudioServer.set_bus_volume_db(AudioManager.Sfx_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(AudioManager.Sfx_bus, true)
	else:
		AudioServer.set_bus_mute(AudioManager.Sfx_bus, false)
	GameSettings._autosave()

func _on_x_button_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg/about_us_btn/about.hide()

func about_us_next_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg/about_us_btn/about/about_us_names.hide()
	$Main_Menu_Bg/about_us_btn/about/about_us_description.show()

func about_us_back_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg/about_us_btn/about/about_us_names.show()
	$Main_Menu_Bg/about_us_btn/about/about_us_description.hide()

func _on_about_us_btn_pressed():
	AudioManager.play_button_sfx()
	$Main_Menu_Bg/about_us_btn/about.show()
