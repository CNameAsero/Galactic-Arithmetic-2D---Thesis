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
				'lvl1_1':
					animation_player.play("lvl1_1")
				'lvl1_2':
					animation_player.play("lvl1_2")
				'lvl2':
					animation_player.play("lvl2")
				'lvl2_1':
					animation_player.play("lvl2_1")
				'lvl2_2':
					animation_player.play("lvl2_2")
				'lvl3':
					animation_player.play("lvl3")
				'lvl3_1':
					animation_player.play("lvl3_1")
				'lvl3_2':
					animation_player.play("lvl3_2")
				'lvl4':
					animation_player.play("lvl4")
				'lvl4_1':
					animation_player.play("lvl4_1")
				'lvl4_2':
					animation_player.play("lvl4_2")
				'lvl5':
					animation_player.play("lvl5")
				'lvl5_1':
					animation_player.play("lvl5_1")
				'lvl5_2':
					animation_player.play("lvl5_2")
