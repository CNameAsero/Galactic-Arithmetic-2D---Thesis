extends TextureButton

func _on_toggled(button_press):
	if button_press:
		AudioManager.mutelevel1BGMusic()
	else:
		AudioManager.contlevel1BGMusic()
