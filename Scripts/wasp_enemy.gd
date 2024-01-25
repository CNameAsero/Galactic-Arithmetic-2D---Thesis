extends Area2D

@export var rect_radius: float
@export var enemy_speed: float = 5.0
var chasing = false
var target = null
var original_position: Vector2
var is_returning_to_original_position = false
var idle = true
var x = 0
var animation_player
@onready var health_system = $"../../../health_system"

func _ready():
	animation_player = $AnimationPlayer
	original_position = global_position
	area_radius()

func _physics_process(delta):
	while x == 1:
		$Sprite2D.self_modulate = Color.RED
		animation_player.play("Back_fly")
		break
	if chasing and target:
		chase_player(delta)
	else:
		return_pos(delta)

func return_pos(delta):
	var distance_to_home = original_position.distance_to(global_position)
	if distance_to_home < 2.0:  
		global_position = original_position
		animation_player.play("Fly_frony")
	else:
		var return_direction = (original_position - global_position).normalized()
		global_position += return_direction * enemy_speed * delta
		var is_horizontal = abs(return_direction.x) > abs(return_direction.y)
		if is_horizontal:
			if return_direction.x > 0:
				animation_player.play("Right_fly")
			else :
				animation_player.play("Left_fly")
			return_direction.y = 0
		else:
			if return_direction.y > 0:
				animation_player.play("Fly_frony")
			else:
				animation_player.play("Back_fly")
			return_direction.x = 0

func chase_player(delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * enemy_speed * delta
	var is_horizontal = abs(direction.x) > abs(direction.y)
	if is_horizontal && x == 0:
		if direction.x > 0:
			animation_player.play("Right_fly")
		else:
			animation_player.play("Left_fly")
	elif !is_horizontal && x ==0:
		if direction.y > 0:
			animation_player.play("Fly_frony")
		else:
			animation_player.play("Back_fly")

func area_radius():
	var collision_det = $"../area_det/collision_det"

	if collision_det:
		var collision_shape = collision_det

		if collision_shape:
			if collision_shape.shape is RectangleShape2D:
				var rect = collision_shape.shape as RectangleShape2D
				rect.size.x = rect_radius
				rect.size.y = rect_radius
			else:
				print("The shape is not a circle")
		else:
			print("There's no CollisionShape2D")
	else:
		print("There's no Area2D node")

func player_hurt():
	health_system._health -= 1
	AudioManager.player_hurt()
	var blink_duration = 0.1
	var total_blink_time = 1.5
	var sprite = $"../../../slime_player_joystick/slime_player_joystik/Sprite2D"
	
	sprite.modulate = Color(1, 1, 1, 0.5)
	
	for i in range(int(total_blink_time / blink_duration)):
		sprite.visible = !sprite.visible
		await get_tree().create_timer(0.1).timeout
	
	sprite.visible = true
	sprite.modulate = Color(1, 1, 1, 1)

func _on_area_det_body_entered(body):
	chasing = true
	target = body
	idle = false

func _on_area_det_body_exited(_body):
	chasing = false
	target = null
	is_returning_to_original_position = true
	idle = true

@onready var old_modulate = self.modulate

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_hurt()
		x = 1

func _on_body_exited(body):
	if body.is_in_group("player"):
		$Sprite2D.self_modulate = old_modulate
		x = 0
