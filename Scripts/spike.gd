extends Area2D

@onready var health_system = $"../../slime_player_joystick/Camera2D/CanvasLayer/health_system"
@onready var animationplayer = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var game_over = $"../../CanvasLayer/menus/game_over"
@onready var time_before_hit_again = $Time_before_hit_again

func _process(_delta):
	animationplayer.play("Spike_activation")
	update_collision()

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	GameSettings.player_invulnerable = true
	time_before_hit_again.start()
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


func _on_body_entered(body):
	if body.is_in_group("player") and not GameSettings.player_invulnerable:
		player_hurt()

func update_collision():
	if animationplayer.current_animation == "Spike_activation" and animationplayer.current_animation_position > 0.1:
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true

func _on_time_before_hit_again_timeout():
	GameSettings.player_invulnerable = false
