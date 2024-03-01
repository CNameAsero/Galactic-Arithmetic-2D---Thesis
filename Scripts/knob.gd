extends Sprite2D

@onready var parent = $".."

var isPressing = false

@export var maxLength = 100
@export var deadzone = 5

func _ready():
	maxLength *= parent.scale.x

func _process(delta):
	if isPressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle) * maxLength
			global_position.y = parent.global_position.y + sin(angle) * maxLength
		calculate_vector()
		parent.modulate = Color(1,1,1,1)
	else:
		global_position = lerp(global_position, parent.global_position, delta * 50)
		parent.pos_vector = Vector2(0, 0)
		parent.modulate = Color(1,1,1,0.1)

func calculate_vector():
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.pos_vector.x = (global_position.x - parent.global_position.x)/maxLength
	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		parent.pos_vector.y = (global_position.y - parent.global_position.y)/maxLength

func _on_button_button_down():
	isPressing = true


func _on_button_button_up():
	isPressing = false
