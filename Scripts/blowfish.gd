extends Area2D

@onready var collision_shape = $CollisionShape2D
@onready var animationplayer = $AnimationPlayer
@onready var health_system = $"../../slime_player_joystick/Camera2D/CanvasLayer/health_system"
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _process(delta):
	animationplayer.play("blowfish_spike")
	update_collision()

func update_collision():
	if animationplayer.current_animation == "blowfish_spike" and animationplayer.current_animation_position > 0.1:
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true

func player_hurt():
	if GameSettings.player_invulnerable:
		return

	GameSettings.player_invulnerable = true
	timer.start()
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

func _on_timer_timeout():
	GameSettings.player_invulnerable = false
