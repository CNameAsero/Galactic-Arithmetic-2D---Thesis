extends Area2D

@onready var animationplayer = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var player_pos = $"../../slime_player_joystick/slime_player_joystik".position

func _process(_delta):
	animationplayer.play("Spike_activation")
	update_collision()
func _on_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.play_deathsfx()
		$"../../slime_player_joystick/slime_player_joystik".position = player_pos

func update_collision():
	if animationplayer.current_animation == "Spike_activation" and animationplayer.current_animation_position > 0.1:
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true
