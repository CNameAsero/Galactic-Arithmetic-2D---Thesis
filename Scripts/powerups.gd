extends Control


@export var buff_selected : String
@export var hp_buff : int
@export var speed_buff : float
@export var time_buff : int
#access hp system/movespeed/timer
@onready var hp_system = $"../health_system"
@onready var player = $"../slime_player_joystick/slime_player_joystik"
@onready var timer = $"../game_manager/timer"

@onready var speed_buff_timer = $Area2D/speed/speed_buff_timer
@onready var animation_player = $Area2D/AnimationPlayer

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
		AudioManager.play_item_collect()
		match buff_selected:
			"health":
				add_hp()
				queue_free()
			"speed":
				add_speed()
			"time":
				add_time()
				queue_free()

func add_hp():
	hp_system._health += hp_buff
	print(hp_system._health)

func add_speed():
	player.speed += speed_buff
	print(player.speed)
	$"Area2D".num = 1
	await get_tree().create_timer(10).timeout
	player.speed -= speed_buff
	print(player.speed)

func add_time():
	timer.time_left += time_buff
	print(timer.time_left)

