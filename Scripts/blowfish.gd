extends Area2D

@onready var collision_shape = $CollisionShape2D
@onready var animationplayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _process(delta):
	animationplayer.play("blowfish_spike")
	update_collision()

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("ouch")


func update_collision():
	if animationplayer.current_animation == "blowfish_spike" and animationplayer.current_animation_position > 0.1:
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true




