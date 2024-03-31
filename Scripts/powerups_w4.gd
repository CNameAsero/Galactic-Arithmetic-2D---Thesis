extends Control


@export var buff_selected : String
@export var hp_buff : int
@export var speed_buff : float
@export var time_buff : float
#access hp system/movespeed/timer
@onready var hp_system = $"../slime_player_joystick/Camera2D/CanvasLayer/health_system"
@onready var player = $"../slime_player_joystick/slime_player_joystik"

@onready var timer = $"../gamemanager_fraction/CanvasLayer/timer/Timer"
@onready var timer_ui = $"../gamemanager_fraction/CanvasLayer/timer"

@onready var speed_buff_timer = $Area2D/speed/speed_buff_timer
@onready var animation_player = $Area2D/AnimationPlayer

var old_time
var new_time

func _ready():
	animation()
	select_buff()

func animation():
	if buff_selected == 'health':
		animation_player.play("hp")
	elif buff_selected == 'speed':
		animation_player.play("spd")
	elif buff_selected == 'time':
		animation_player.play("time")

func select_buff():
	for i in $"Area2D".get_children():
		if i is Sprite2D and i.name == buff_selected:
			i.visible = true
#just type what buff u want "health", "speed", and "time"

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		match buff_selected:
			"health":
				if !GameSettings.isHard:
					if hp_system._health >= 3:
						$Area2D/health.modulate = Color(1,1,1,0.25)
						await get_tree().create_timer(1.5).timeout
						$Area2D/health.modulate = Color(1,1,1,1)
					else:
						AudioManager.play_item_collect()
						add_hp()
						queue_free()
				else:
					if hp_system._health >= 5:
						$Area2D/health.modulate = Color(1,1,1,0.25)
						await get_tree().create_timer(1.5).timeout
						$Area2D/health.modulate = Color(1,1,1,1)
					else:
						AudioManager.play_item_collect()
						add_hp()
						queue_free()
			"speed":
				AudioManager.play_item_collect()
				add_speed()
			"time":
				AudioManager.play_item_collect()
				add_time()
				queue_free()

func add_hp():
	hp_system._health += hp_buff

func add_speed():
	player.speed += speed_buff
	$"Area2D".num = 1
	await get_tree().create_timer(10).timeout
	player.speed -= speed_buff

func add_time():
	old_time = timer.time_left
	new_time = old_time + time_buff
	timer_ui.time_left += time_buff
	timer.stop()
	timer.wait_time = new_time
	timer.start()
