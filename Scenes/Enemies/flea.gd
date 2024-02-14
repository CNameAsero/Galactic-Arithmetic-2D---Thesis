extends CharacterBody2D


@export_category("Flea")
@export var flea_speed : int
@export var rect_size_flea_x : int
@export var rect_size_flea_y : int

@onready var timer = $Timer
var current_timer 
@onready var health_system = $"../health_system"
@onready var animation_player = $AnimationPlayer
@onready var  isChasing = false
var target = null

func _ready():
	area_radius_flea()
	timer.start()

func _process(delta):
	current_timer = timer.time_left
	if isChasing && current_timer >= 1 :
		flea_chase(delta)
	elif current_timer < 1:
		flea_death()

func flea_chase(delta):
	var direction = (target.global_position - global_position).normalized()
	move_and_collide(direction * flea_speed * delta)
	var is_horizontal = abs(direction.x) > abs(direction.y)

	if is_horizontal:
		if direction.x > 0:
			animation_player.play("right")
		else:
			animation_player.play("left")

func flea_death():
	global_position = global_position
	var death_position = global_position
	var direction = (target.global_position - death_position).normalized()
	var is_horizontal = abs(direction.x) > abs(direction.y)

	if is_horizontal:
		if direction.x > 0:
			animation_player.play("right_death")
		else:
			animation_player.play("left_death")

func area_radius_flea():
	var collision_det = $det/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_size_flea_x
				rect.size.y = rect_size_flea_y
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.05
	var total_blink_time = 1
	var sprite = $"../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(blink_duration).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)


func det_entered(body):
	if body.is_in_group("player"):
		target = body
		isChasing = true

func _on_det_body_exited(body):
	if body.is_in_group("player"):
		target = null
		isChasing = false

func hitbox_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()
		$flea_hit_delay.start()

func _on_timer_timeout():
	queue_free()

func _on_flea_hit_delay_timeout():
	player_hurt()

func _on_hitbox_body_exited(body):
	if body.is_in_group("player"):
		$flea_hit_delay.stop()
