extends CharacterBody2D
class_name Spider

@export var circle_radius: float
@export var enemy_speed: float = 5.0
var chasing = false
var target = null
var original_position: Vector2
var is_returning_to_original_position = false
var idle = true

var animation_player

func _ready():
	animation_player = $AnimationPlayer
	original_position = global_position
	area_radius()

func _physics_process(delta):
	if chasing and target:
		chase_player(delta)
	else:
		return_pos(delta) 

func return_pos(delta):
	var return_direction = (original_position - global_position).normalized()
	var is_horizontal = abs(return_direction.x) > abs(return_direction.y)
	if is_horizontal:
		return_direction.y = 0
	else:
		return_direction.x = 0

	move_and_collide(return_direction * enemy_speed * delta)

func chase_player(delta):
	
	var direction = (target.global_position - global_position).normalized()
	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal:
		direction.y = 0
	else:
		direction.x = 0

	move_and_collide(direction * enemy_speed * delta)

func area_radius():
	var collision_det = $area_det.get_node("collision_det")
	
	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is CircleShape2D:
				var circle_shape = collision_shape.shape as CircleShape2D
				circle_shape.radius = circle_radius
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func _on_area_det_body_entered(body):
	chasing = true
	target = body
	idle = false

func _on_area_det_body_exited(_body):
	chasing = false
	target = null
	is_returning_to_original_position = true
	idle = true
