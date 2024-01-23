extends Control

var _health = 3
@onready var animation_player = $AnimationPlayer
@onready var game_over = $"../menus/game_over"


func _physics_process(_delta):
	display_healthui()

func display_healthui():
	if _health == 3:
		animation_player.play("hp 3")
	elif _health == 2:
		animation_player.play("hp 2")
	elif _health == 1:
		animation_player.play("hp 1")
	elif _health == 0:
		animation_player.play("hp 0")
		await get_tree().create_timer(0.1).timeout
		AudioManager.play_deathsfx()
		game_over.show()
		get_tree().paused = true

