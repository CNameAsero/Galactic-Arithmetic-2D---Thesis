extends Area2D

@onready var operator_to_display = $"..".oper
@onready var access_manager = $"../.."
var fraction : String 

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == operator_to_display:
			i.visible = true
		else:
			i.visible = false
		if i.name == "d":
			fraction = "/"

func _on_body_entered(body):
	if body.is_in_group("player"):
		access_manager.isDestroy = true
		if operator_to_display == "d" and access_manager.can_collect_fraction and access_manager.last_item_was_number :
			AudioManager.play_operator_collect()
			access_manager.collect_operator(fraction)
			access_manager.can_collect_fraction = false
		elif operator_to_display != "d" and !access_manager.can_collect_fraction and access_manager.last_item_was_number:
			AudioManager.play_operator_collect()
			access_manager.collect_operator(operator_to_display)
			access_manager.can_collect_fraction = true
