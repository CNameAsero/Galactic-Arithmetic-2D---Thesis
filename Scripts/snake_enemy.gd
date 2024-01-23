extends RigidBody2D
class_name Snake

@export var move_speed: float = 30.0
@export var move_direction: Vector2

var start_position: Vector2
var target_position: Vector2
var animation_player: AnimationPlayer

@onready var snake_enemy = $"."

func _ready():
	start_position = global_position
	target_position = start_position + move_direction
	animation_player = $AnimationPlayer
	update_animation()

func _process(delta):
	snake_ai(delta)
	update_animation()

func snake_ai(delta):
	var distance_to_target = global_position.distance_to(target_position)

	if distance_to_target < move_speed * delta:
		# If the distance to the target is smaller than what the object can move in one frame, snap to the target.
		global_position = target_position

		# Switch direction when reaching the target position
		if target_position == start_position:
			target_position = start_position + move_direction
		else:
			target_position = start_position
	else:
		global_position = global_position.move_toward(target_position, move_speed * delta)

func update_animation():
	var move_direction = (target_position - global_position).normalized()
	if move_direction.x < 0:
		animation_player.play("left")
	elif move_direction.x > 0:
		animation_player.play("right")
	elif move_direction.y < 0:
		animation_player.play("up")
	elif move_direction.y > 0:
		animation_player.play("down")

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("gameover")
