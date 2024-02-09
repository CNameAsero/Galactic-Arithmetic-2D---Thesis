extends Node2D

@export var variable_to_display : String
@onready var access_manager = $".."
@onready var animation_player = $AnimationPlayer
@onready var set_variable = $set_variable

func _ready():
	for i in set_variable.get_children():
		if i is Sprite2D and i.name == variable_to_display:
			i.visible = true
			match variable_to_display:
				'x':
					animation_player.play("x")
				'y':
					animation_player.play("y")

func _on_body_entered(body):
	if body.is_in_group("player") && !access_manager.last_item_was_variable && access_manager.last_item_was_number:
		AudioManager.play_item_collect()
		access_manager.isDestroy = true
		access_manager.collect_variable(variable_to_display)
		queue_free()

