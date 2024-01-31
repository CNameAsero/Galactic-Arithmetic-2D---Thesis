extends Area2D

@onready var operator_to_display = $"..".oper
@onready var access_manager = $"../../"
@onready var access_bool = $"../../bool_handler"

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == operator_to_display:
			i.visible = true
		else:
			i.visible = false

func _on_body_entered(body):
	if body.is_in_group("player") && !access_manager.last_item_was_number:
		AudioManager.play_operator_collect()
		access_bool.isDestroy = true
		access_manager.collect_operator(operator_to_display)
