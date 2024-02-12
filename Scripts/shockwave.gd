extends Area2D

var direction : Vector2 = Vector2.RIGHT
@export var speed : float = 300

@onready var health_system = $"../health_system"
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

func _ready():
	animation_player.play("shockwave")
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func player_hurt():
	GameSettings.player_invulnerable = true
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.05
	var total_blink_time = 0.5
	var sprite = $"../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(blink_duration).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)
func _on_body_entered(body):
	if body.is_in_group("player"):
		$Sprite2D.num + 1
		player_hurt()
