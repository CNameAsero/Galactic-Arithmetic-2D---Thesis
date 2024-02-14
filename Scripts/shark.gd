extends CharacterBody2D

@onready var   move_speed
@onready var move_direction
@onready var rect_radius_x
@onready var rect_radius_y

@onready var animation_player = $Area2/AnimationPlayer
@onready var health_system = $"../../../health_system"
@onready var shark = $".."
@onready var timer = $"../Timer"

var target = null

var start_pos : Vector2
var target_pos : Vector2

var chasing = false
var patrol = true

func _ready():
	move_speed = shark.move_speed
	move_direction = shark.move_direction
	rect_radius_x = shark.rect_radius_x
	rect_radius_y = shark.rect_radius_y
	start_pos = global_position
	target_pos = start_pos + move_direction
	area_radius()

func _physics_process(delta):
	if patrol:
		shark_patrol(delta)
	if chasing and target:
		chase_player(delta)

func shark_patrol(delta):
	var distance_to_target = global_position.distance_to(target_pos)

	if distance_to_target < move_speed * delta:
		global_position = target_pos
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos
	else:
		global_position = global_position.move_toward(target_pos, move_speed * delta)

	var move_direction2 = (target_pos - global_position).normalized()
	if move_direction2.x < 0:
		animation_player.play("left")
	elif move_direction2.x > 0:
		animation_player.play("right")

func area_radius():
	var collision_det = $"../area_det/col_det"

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_radius_x
				rect.size.y = rect_radius_y
			else:
				print("The shape is not a rect")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func chase_player(delta):
	var direction = (target.global_position - global_position).normalized()
	move_and_collide(direction * move_speed * delta)
	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		if direction.x > 0:
			animation_player.play("right")
		else:
			animation_player.play("left")

func return_pos(delta):
	global_position = start_pos
	var return_direction = (start_pos - global_position).normalized()
	global_position += return_direction * move_speed * delta
	var is_horizontal = abs(return_direction.x) > abs(return_direction.y)
	if is_horizontal:
		if return_direction.x > 0:
			animation_player.play("right")
		else :
			animation_player.play("left")
		return_direction.y = 0

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	GameSettings.player_invulnerable = true
	timer.start()
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.1
	var total_blink_time = 1.5
	var sprite = $"../../../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(blink_duration).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)

func _on_area_det_body_entered(body):
	patrol = false
	chasing = true
	target = body

func _on_area_det_body_exited(_body):
	patrol = true
	chasing = false
	target = null

func _on_area_2_body_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()
		$hit_delay.start()

func _on_area_2_body_exited(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		$hit_delay.stop()
func _on_timer_timeout():
	GameSettings.player_invulnerable = false

func _on_hit_delay_timeout():
	player_hurt()
