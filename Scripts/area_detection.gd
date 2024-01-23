extends Area2D

@export var circle_radius: float

func _ready():
	area_radius()

func area_radius():
	var collision_det = $area_det

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

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player detected!")
		emit_signal("player_detected", body)

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player left the detection area.")
		emit_signal("player_exited")
	
