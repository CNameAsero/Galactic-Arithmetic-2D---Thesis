extends RigidBody2D
class_name Stone

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("tite")
	elif body.is_in_group("snake"):
		print("kike")
