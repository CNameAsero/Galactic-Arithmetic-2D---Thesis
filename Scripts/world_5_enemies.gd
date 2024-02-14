extends Node2D

@export_category("type (fly, rat, thief)")
@export var enemy_type : String

var start_pos : Vector2
var target_pos_rat : Vector2
var target_pos_thief : Vector2

var target_detected = false
var target = null
var chasing = false
@onready var patrol = true

var angle = 50
var speed = 0.09 * PI / 180
@export_category("fly")
@onready var ray_cast_fly = $fly/RayCast2D
@onready var timer_fly = $fly/Timer
@export var fly_speed : float
@export var  fly_radius = 250
@export var rect_radius_fly : float
@export var fly_bullet : PackedScene

@export_category("rat")
@onready var flea_limit = 0
@export var rat_speed : float
@onready var timer_flea = $rat/Timer
@export var  rat_radius = 250
@export var rect_size_rat : float
@export var rat_move_direction : Vector2
@export var flea : PackedScene

@export_category("thief")
@onready var ray_cast_thief = $thief/RayCast2D
@onready var timer_thief = $thief/Timer
@export var thief_speed : float
@export var  thief_radius = 250
@export var rect_size_thief : float
@export var thief_move_direction : Vector2
@export var bullet : PackedScene

@onready var animation_player = $AnimationPlayer
@onready var health_system = $"../../health_system"

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	target_pos_rat = start_pos + rat_move_direction
	target_pos_thief = start_pos + thief_move_direction
	for i in get_children():
		if i is Area2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "fly":
				area_radius_fly()
				if i.name == "fly":
					$rat.queue_free()
					$thief.queue_free()
		if i is CharacterBody2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "rat":
				area_radius_rat()
				if i.name == "rat":
					$fly.queue_free()
					$thief.queue_free()
			elif enemy_type == "thief":
				area_radius_thief()
				if i.name == "thief":
					$fly.queue_free()
					$rat.queue_free()

func _process(delta):
	if enemy_type == "fly":
		fly(delta)
	elif enemy_type == "rat":
		rat(delta)
	elif enemy_type == "thief":
		thief(delta)

func fly(delta):
	if patrol && !chasing:
		fly_patrol()
	else:
		fly_chase(delta)
		fly_aim()

func rat(delta):
	if patrol && !chasing:
		rat_patrol(delta)
	else:
		rat_chase(delta)

func thief(delta):
	if patrol && !chasing:
		thief_patrol(delta)
	else:
		thief_aim()
#fly
func area_radius_fly():
	var collision_det = $fly/det/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is CircleShape2D:
				var rect = collision_shape.shape as CircleShape2D
				rect.radius = rect_radius_fly
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func fly_patrol():
	animation_player.speed_scale = 1.5
	angle += speed
	var x = start_pos.x + fly_radius * cos(angle)
	var y = start_pos.y + fly_radius * sin(angle)
	var target_position = Vector2(x, y)

	global_position = global_position.lerp(target_position, 0.001)

	var move_direction2 = (global_position - start_pos).normalized()
	if move_direction2.y > 0:
		animation_player.play("fly_left")
	else:
		animation_player.play("fly_right")

func fly_chase(delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * fly_speed * delta
	var is_horizontal = abs(direction.x) > abs(direction.y)

	if is_horizontal:
		if direction.x > 0:
			animation_player.play("fly_right")
		else:
			animation_player.play("fly_left")

func fly_aim():
	ray_cast_fly.target_position = to_local(target.position)
	
	var direction2 = (global_position - target.position).normalized()
	if direction2.x > 0:
		animation_player.play("fly_left")
	else:
		animation_player.play("fly_right")

func fly_shoot():
	var direction = target.global_position- global_position
	var bullet_fly = fly_bullet.instantiate()
	bullet_fly.rotation = direction.angle()
	bullet_fly.position = position
	bullet_fly.direction = (ray_cast_fly.target_position).normalized()
	get_tree().current_scene.add_child(bullet_fly)
	AudioManager.octopus_shot()

func fly_det_entered(body):
	if body.is_in_group("player"):
		target = body
		chasing = true
		patrol = false
		timer_fly.start()

func fly_det_exited(body):
	if body.is_in_group("player"):
		target = null
		timer_fly.stop()
		chasing = false
		patrol = true

func fly_timeout():
	fly_shoot()

func hit_fly_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()
		$fly/fly_hit_delay.start()

func _on_fly_body_exited(body):
	if body.is_in_group("player"):
		$fly/fly_hit_delay.stop()

func _on_fly_hit_delay_timeout():
	player_hurt()

#rat
func area_radius_rat():
	var collision_det = $rat/det/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_size_rat
				rect.size.y = rect_size_rat
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func rat_patrol(delta):
	var distance_to_target = global_position.distance_to(target_pos_rat)

	if distance_to_target < rat_speed * delta:
		global_position = target_pos_rat
		if target_pos_rat == start_pos:
			target_pos_rat = start_pos + rat_move_direction
		else:
			target_pos_rat = start_pos
	else:
		global_position = global_position.move_toward(target_pos_rat, rat_speed * delta)

	var move_direction2 = (target_pos_rat - global_position).normalized()
	var is_horizontal = abs(move_direction2.x) > abs(move_direction2.y)
	if is_horizontal:
		if move_direction2.x < 0:
			animation_player.play("rat_left")
		else:
			animation_player.play("rat_right")
	else:
		if move_direction2.y < 0:
			animation_player.play("rat_left")
		else:
			animation_player.play("rat_right")

func rat_chase(delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * rat_speed * delta
	var is_horizontal = abs(direction.x) > abs(direction.y)
	
	var attack_range = 30 

	var distance = target.global_position.distance_to(global_position)

	if distance < attack_range:
		if is_horizontal:
			if direction.x > 0:
				animation_player.play("rat_right_atk")
			else:
				animation_player.play("rat_left_atk")
	else:
		if is_horizontal:
			if direction.x > 0:
				animation_player.play("rat_right")
			else:
				animation_player.play("rat_left")

func rat_spawn():
	var spawn_flea = flea.instantiate() 
	spawn_flea.position = position
	get_tree().current_scene.add_child(spawn_flea)
	flea_limit += 1
	
	if flea_limit == 2:
		await get_tree().create_timer(10).timeout
		flea_limit = 0 

func rat_det_entered(body):
	if body.is_in_group("player"):
		target = body
		chasing = true
		patrol = false
		timer_flea.start()

func rat_det_exited(body):
	if body.is_in_group("player"):
		target = null
		chasing = false
		patrol = true
		timer_flea.stop()

func _on_timer_timeout():
	if flea_limit < 2:
		rat_spawn()

func hit_rat_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()
		$rat/hit_rat_delay.start()

func hit_rat_exited(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		$rat/hit_rat_delay.stop()

func _on_hit_rat_delay_timeout():
	player_hurt()
#thief
func area_radius_thief():
	var collision_det = $thief/det/col

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_size_thief
				rect.size.y = rect_size_thief
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func thief_patrol(delta):
	var distance_to_target = global_position.distance_to(target_pos_thief)

	if distance_to_target < thief_speed * delta:
		global_position = target_pos_thief
		if target_pos_thief == start_pos:
			target_pos_thief = start_pos + thief_move_direction
		else:
			target_pos_thief = start_pos
	else:
		global_position = global_position.move_toward(target_pos_thief, thief_speed * delta)

	var move_direction2 = (target_pos_thief - global_position).normalized()
	var is_horizontal = abs(move_direction2.x) > abs(move_direction2.y)
	if is_horizontal:
		if move_direction2.x < 0:
			animation_player.play("thief_left")
		else:
			animation_player.play("thief_right")
	else:
		if move_direction2.y < 0:
			animation_player.play("thief_left")
		else:
			animation_player.play("thief_right")

func thief_aim():
	ray_cast_thief.target_position = to_local(target.position)
	
	animation_player.speed_scale = .5
	
	var direction2 = (global_position - target.position).normalized()
	if direction2.x > 0:
		animation_player.play("shoot_left")
	else:
		animation_player.play("shoot_right")
func thief_shoot():
	var direction = target.global_position - global_position
	var thief_bullet = bullet.instantiate()
	thief_bullet.rotation = direction.angle()
	thief_bullet.position = position
	thief_bullet.direction = (ray_cast_thief.target_position).normalized()
	get_tree().current_scene.add_child(thief_bullet)

func thief_det_entered(body):
	if body.is_in_group("player"):
		target = body
		chasing = true
		patrol = false
		timer_thief.start()

func thief_det_exited(body):
	if body.is_in_group("player"):
		target = null
		timer_thief.stop()
		chasing = false
		patrol = true

func thief_hitbox_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()

func thief_timeout():
	thief_shoot()

@onready var timer = $Timer

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	GameSettings.player_invulnerable = true
	timer.start()
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.05
	var total_blink_time = 1
	var sprite = $"../../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(blink_duration).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)


func hit_timeout():
	GameSettings.player_invulnerable = false


