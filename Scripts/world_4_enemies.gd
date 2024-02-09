extends Node2D

@export_category("type (ice, bear, yeti)")
@export var enemy_type : String

#ice
@onready var col = $ice/CollisionShape2D
@onready var health_system = $"../../health_system"

var angle = 50
var speed = 0.09 * PI / 180
@export_category("bear")
@export var move_speed : float
@export var  radius = 250
@export var rect_radius_bear : float

@export_category("yeti")
@export var yeti_speed : float
@export var rect_radius_yeti : float
@export var move_direction : Vector2
@export var shockwave : PackedScene

var start_pos : Vector2
var target_pos : Vector2

var target_detected = false
var target = null
var chasing = false
@onready var patrol = true

@onready var player = $"../../slime_player_joystick/slime_player_joystik"
@onready var ray_cast_2d = $yeti/RayCast2D
@onready var timer = $yeti/Timer
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	target_pos = start_pos + move_direction

	for i in get_children():
		if i is Area2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "ice":
				if i.name == "ice":
					$bear.queue_free()
					$yeti.queue_free()
					$det_bear.queue_free()
		if i is CharacterBody2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "bear":
				area_radius_bear()
				if i.name == "bear":
					$ice.queue_free()
					$yeti.queue_free()
			elif enemy_type == "yeti":
				area_radius_yeti()
				if i.name == "yeti":
					$ice.queue_free()
					$bear.queue_free()
					$det_bear.queue_free()

func ice():
	animation_player.speed_scale = 0.2
	if animation_player.current_animation == "ice" and animation_player.current_animation_position > 0.5:
		col.disabled = false
	else:
		col.disabled = true

func bear(delta):
	if patrol:
		bear_patrol()
	if chasing and target:
		bear_chase_player(delta)

func yeti(delta):
	animation_player.speed_scale = 0.2
	if !target_detected:
		yeti_patrol(delta)
	else:
		yeti_aim()

func bear_patrol():
	angle += speed
	var x = start_pos.x + radius * cos(angle)
	var y = start_pos.y + radius * sin(angle)
	var target_position = Vector2(x, y)

	global_position = global_position.lerp(target_position, 0.001)

	var move_direction2 = (global_position - start_pos).normalized()
	if move_direction2.x > 0:
		animation_player.play("bear_down")
	else:
		animation_player.play("bear_up")

func bear_chase_player(delta):
	var direction = (target.global_position - global_position).normalized()
	var is_horizontal = abs(direction.x) > abs(direction.y)
	
	var attack_range = 30 
	var stop_range = 10

	var distance = target.global_position.distance_to(global_position)

	if distance > stop_range:
		global_position += direction * move_speed * delta

	if distance < attack_range:
		if is_horizontal:
			if direction.x > 0:
				animation_player.play("bear_atk_right")
			else:
				animation_player.play("bear_atk_left")
		elif !is_horizontal:
			if direction.y > 0:
				animation_player.play("bear_atk_down")
			else:
				animation_player.play("bear_atk_up")
	else:
		if is_horizontal:
			if direction.x > 0:
				animation_player.play("beat_right")
			else:
				animation_player.play("bear_left")
		elif !is_horizontal:
			if direction.y > 0:
				animation_player.play("bear_down")
			else:
				animation_player.play("bear_up")

func area_radius_bear():
	var collision_det = $det_bear/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is CircleShape2D:
				var rect = collision_shape.shape as CircleShape2D
				rect.radius = rect_radius_bear
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func area_radius_yeti():
	var collision_det = $yeti/det/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_radius_yeti
				rect.size.y = rect_radius_yeti
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func yeti_aim():
	ray_cast_2d.target_position = to_local(player.position)
	var direction = (player.position - global_position).normalized()

	animation_player.speed_scale = 0.5

	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		if direction.x < 0:
			animation_player.play("yeti_atk_left")
		else:
			animation_player.play("yeti_atk_right")

func yeti_shockwave():
	var direction = player.global_position - global_position
	var angle_offset = PI/12

	for i in range(-1, 2):
		var bullet = shockwave.instantiate()
		bullet.rotation = direction.angle() + i * angle_offset
		bullet.position = position
		bullet.direction = Vector2(cos(bullet.rotation), sin(bullet.rotation))
		get_tree().current_scene.add_child(bullet)

	AudioManager.octopus_shot()


func yeti_patrol(delta):
	var distance_to_target = global_position.distance_to(target_pos)

	if distance_to_target < yeti_speed * delta:
		global_position = target_pos
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos
	else:
		global_position = global_position.move_toward(target_pos, yeti_speed * delta)

	var move_direction2 = (target_pos - global_position).normalized()
	var is_horizontal = abs(move_direction2.x) > abs(move_direction2.y)
	if is_horizontal:
		if move_direction2.x < 0:
			animation_player.play("yeti_left")
		else:
			animation_player.play("yeti_right")

func bear_det_entered(body):
	chasing = true
	patrol = false
	target = body

func bear_det_exited(body):
	chasing = false
	target = null
	patrol = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_hurt()

func yeti_det_entered(body):
	target = body
	target_detected = true
	if body.is_in_group("player"):
		timer.start()

func yeti_det_exited(body):
	target = null
	timer.stop()
	target_detected = false

func shockwave_timeout():
	if target_detected:
		yeti_shockwave()

func player_hurt():
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.1
	var total_blink_time = 2.0
	var sprite = $"../../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(0.1).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)

func _process(delta):
	if enemy_type == "ice":
		animation_player.play("ice")
		ice()
	elif enemy_type == "yeti":
		yeti(delta)

func _on_ice_body_entered(body):
	if body.is_in_group("player"):
		player_hurt()

func _on_area_yeti_body_entered(body):
	if body.is_in_group("player"):
		player_hurt()
