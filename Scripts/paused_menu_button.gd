extends TextureButton

@onready var paused = $"game_paused"

func _on_pressed():
	AudioManager.play_button_sfx()
	get_tree().paused = true
	paused.show()
