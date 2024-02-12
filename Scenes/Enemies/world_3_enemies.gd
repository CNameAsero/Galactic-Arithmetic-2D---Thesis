extends Node2D

#type in inspertor what type enemy u want
@export_category("type (lava, bat, skeleton)")
@export var enemy_type : String

#bat/skeleton info

var angle = 50
var speed = 0.1 * PI / 180
@export_category("bat")
@export var move_speed : float
@export var  radius = 250
@export var rect_radius_bat : float

@export_category("skeleton")
@export var skeleton_speed : float
@export var rect_radius_skeleton : float
@export var move_direction : Vector2
@export var ammo_skeleton : PackedScene


@onready var player = $"../../slime_player_joystick/slime_player_joystik"
@onready var ray_cast_2d = $skeleton/RayCast2D
@onready var timer = $skeleton/Timer
@onready var timer1 = $Timer

@onready var animation_player = $AnimationPlayer
var target_detected = false

#lava collision shape
@onready var col = $lava/CollisionShape2D


var start_pos : Vector2
var target_pos : Vector2

var target = null
var chasing = false
var patrol = true

@onready var health_system = $"../../health_system"

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	target_pos = start_pos + move_direction

	for i in get_children():
		if i is Area2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "lava":
				if i.name == "lava":
					$bat.queue_free()
					$skeleton.queue_free()
			elif enemy_type == "bat":
				area_radius_bat()
				if i.name == "bat":
					$lava.queue_free()
					$skeleton.queue_free()
			elif enemy_type == "skeleton":
				area_radius_skeleton()
				if i.name == "skeleton":
					$lava.queue_free()
					$bat.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy_type == "lava":
		animation_player.play("lava")
		lava()
	elif enemy_type == "bat":
		bat(delta)
	elif enemy_type == "skeleton":
		skeleton(delta)

func lava():
	animation_player.speed_scale = 0.2
	if animation_player.current_animation == "lava" and animation_player.current_animation_position < 0.4:
		col.disabled = false
	else:
		col.disabled = true

func bat(delta):
	if patrol:
		bat_patrol()
	if chasing and target:
		chase_player(delta)

func skeleton(delta):
	if !target_detected:
		skeleton_patrol(delta)
	else:
		skeleton_aim()

func chase_player(delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * move_speed * delta
	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		if direction.x > 0:
			animation_player.play("bat_right")
		else:
			animation_player.play("bat_left")
	elif !is_horizontal:
		if direction.y > 0:
			animation_player.play("bat_down")
		else:
			animation_player.play("bat_up")

func bat_patrol():
	angle += speed
	var x = start_pos.x + radius * cos(angle)
	var y = start_pos.y + radius * sin(angle)
	var target_position = Vector2(x, y)

	global_position = global_position.lerp(target_position, 0.01)

	var move_direction2 = (global_position - start_pos).normalized()
	if move_direction2.x > 0:
		animation_player.play("bat_down")
	else:
		animation_player.play("bat_up")

func area_radius_bat():
	var collision_det = $bat/area_det/col_det

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is CircleShape2D:
				var rect = collision_shape.shape as CircleShape2D
				rect.radius = rect_radius_bat
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func area_radius_skeleton():
	var collision_det = $skeleton/area_det/col_det

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_radius_skeleton
				rect.size.y = rect_radius_skeleton
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func skeleton_aim():
	ray_cast_2d.target_position = to_local(player.position)
	var direction = (player.position - global_position).normalized()

	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		if direction.x < 0:
			animation_player.play("skeleton_left")
		else:
			animation_player.play("skeleton_right")

func skeleton_shoot():
	var direction = player.global_position- global_position
	var bullet = ammo_skeleton.instantiate()
	bullet.rotation = direction.angle()
	bullet.position = position
	bullet.direction = (ray_cast_2d.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	AudioManager.octopus_shot()

func skeleton_patrol(delta):
	var distance_to_target = global_position.distance_to(target_pos)

	if distance_to_target < skeleton_speed * delta:
		global_position = target_pos
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos
	else:
		global_position = global_position.move_toward(target_pos, skeleton_speed * delta)

	var move_direction2 = (target_pos - global_position).normalized()
	var is_horizontal = abs(move_direction2.x) > abs(move_direction2.y)
	if is_horizontal:
		if move_direction2.x < 0:
			animation_player.play("skeleton_left")
		else:
			animation_player.play("skeleton_right")
	else:
		if move_direction2.y < 0:
			animation_player.play("skeleton_down")
		else:
			animation_player.play("skeleton_up")

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	GameSettings.player_invulnerable = true
	timer1.start()
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.05
	var total_blink_time = 0.5
	var sprite = $"../../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(blink_duration).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)

func _on_area_det_body_entered(body):
	chasing = true
	patrol = false
	target = body

func _on_area_det_body_exited(_body):
	chasing = false
	target = null
	patrol = true

func skeleton_body_entered(body):
	target = body
	target_detected = true
	if body.is_in_group("player"):
		timer.start()

func skeleton_body_exited(_body):
	target = null
	timer.stop()
	target_detected = false

func _on_timer_timeout():
	if target_detected:
		skeleton_shoot()

func _on_lava_body_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()

func _on_bat_body_entered(body):
	if body.is_in_group("player")and not GameSettings.player_invulnerable:
		player_hurt()

func hit_timeout():
	GameSettings.player_invulnerable = false
