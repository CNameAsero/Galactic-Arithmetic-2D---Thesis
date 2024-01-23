extends Area2D

@export var move_speed: float = 30.0
@export var move_direction: Vector2

var start_position: Vector2
var target_position: Vector2
var animation_player: AnimationPlayer

@onready var game_over = $"../../menus/game_over"
@onready var health_system = $"../../health_system"

func _ready():
	start_position = global_position
	target_position = start_position + move_direction
	animation_player = $AnimationPlayer
	update_animation()

func _process(delta):
	fox_ai(delta)
	update_animation()

func fox_ai(delta):
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
	var move_direction2 = (target_position - global_position).normalized()
	if move_direction2.x < 0:
		animation_player.play("Left")
	elif move_direction2.x > 0:
		animation_player.play("Right")
	elif move_direction2.y < 0:
		animation_player.play("Back")
	elif move_direction2.y > 0:
		animation_player.play("Front_move")

func _on_body_entered(body):
	if body.is_in_group("player"):
		health_system._health -= 1
