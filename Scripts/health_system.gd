extends Control

var _health = 3

@onready var animation_player_2 = $AnimationPlayer2
@onready var animation_player = $AnimationPlayer
@onready var game_over = $"../menus/game_over"

func _ready():
	if GameSettings.isHard:
		_health = 5
		$"3hp".hide()
		$"5hp".show()
	else:
		_health = 3
		$"3hp".show()
		$"5hp".hide()

func _process(_delta):
	display_healthui()

func display_healthui():
	if !GameSettings.isHard:
		$"3hp".show()
		$"5hp".hide()
		if _health == 3:
			animation_player.play("hp 3")
		elif _health == 2:
			animation_player.play("hp 2")
		elif _health == 1:
			animation_player.play("hp 1")
		elif _health <= 0:
			animation_player.play("hp 0")
			AudioManager.play_deathsfx()
			await get_tree().create_timer(0.39).timeout
			game_over.show()
			get_tree().paused = true
	else:
		$"3hp".hide()
		$"5hp".show()
		if _health == 5:
			animation_player_2.play("hp5")
		elif _health == 4:
			animation_player_2.play("hp4")
		elif _health == 3:
			animation_player_2.play("hp3")
		elif _health == 2:
			animation_player_2.play("hp2")
		elif _health == 1:
			animation_player_2.play("hp1")
		elif _health <= 0:
			animation_player_2.play("hp0")
			AudioManager.play_deathsfx()
			await get_tree().create_timer(0.39).timeout
			game_over.show()
			get_tree().paused = true
