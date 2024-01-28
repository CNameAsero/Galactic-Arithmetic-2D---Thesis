extends Node2D

@onready var ray_cast = $Area2D/RayCast2D
@onready var timer = $Area2D/Timer

@export var ammo : PackedScene
@export var rect_radius : float

@onready var player = $"../../slime_player_joystick/slime_player_joystik"
@onready var animation_player = $Area2D/AnimationPlayer

var target = null

func _ready():
	area_radius()

func _physics_process(_delta):
	_aim()

func _aim():
	ray_cast.target_position = to_local(player.position)
	
	var direction = (player.position - global_position).normalized()
	
	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		if direction.x > 0:
			animation_player.play("right")
		else:
			animation_player.play("left")

func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	AudioManager.octopus_shot()

func area_radius():
	var collision_det = $det/col_det

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_radius
				rect.size.y = rect_radius
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func _on_det_body_entered(body):
	target = body
	if body.is_in_group("player"):
		timer.start()

func _on_det_body_exited(_body):
	timer.stop()

func _on_timer_timeout():
	_shoot()



