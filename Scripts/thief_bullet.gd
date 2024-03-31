extends Area2D

var direction : Vector2 = Vector2.RIGHT
@export var speed : float = 450
@onready var health_system = $"../slime_player_joystick/Camera2D/CanvasLayer/health_system"
@onready var sprite1 = $"../slime_player_joystick/slime_player_joystik/Sprite2D"

func _ready():
	await get_tree().create_timer(1.5).timeout
	sprite1.visible = true
	sprite1.modulate = Color(1, 1, 1, 1)
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func player_hurt():
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.2
	var total_blink_time = 1
	var sprite = $"../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(0.1).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_hurt()
		$Sprite2D.num =+ 1
