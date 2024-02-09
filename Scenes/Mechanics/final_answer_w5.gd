extends CharacterBody2D

@export_category("integer * x * y = final answer")
@export var x = 1
@export var y = 1
@export var yplus = 0
@export var integer : int
@onready var final_answer = integer * x * y + yplus
@export_category("lvl1 - lvl5")
@export var display_chest : String
@onready var animation_player = $AnimationPlayer

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == str(display_chest):
			i.visible = true
			match display_chest:
				'lvl1':
					animation_player.play("lvl1")
				'lvl2':
					animation_player.play("lvl2")
				'lvl3':
					animation_player.play("lvl3")
				'lvl4':
					animation_player.play("lvl4")
				'lvl5':
					animation_player.play("lvl5")
