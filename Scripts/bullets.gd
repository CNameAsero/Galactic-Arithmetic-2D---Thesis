extends Area2D

var direction : Vector2 = Vector2.RIGHT
@export var speed : float = 300

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
