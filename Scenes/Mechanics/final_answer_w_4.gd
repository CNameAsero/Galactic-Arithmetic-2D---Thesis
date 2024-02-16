extends CharacterBody2D

@export_category("num1/num2")
@export var num1 : float
@export var num2 : float
@onready var final_answer = num1/num2
@export_category("type 3/4, 5/6, 7/8, 11/16, 14/15")
@export var display : String
@onready var animation_player = $AnimationPlayer

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == display:
			i.visible = true
			match display:
				'3over4':
					animation_player.play("075")
				'3over2':
					animation_player.play("3over2")
				'5over8':
					animation_player.play("5over8")
				'8over5':
					animation_player.play("8over5")
				'5over16':
					animation_player.play("03125")
				'7over8':
					animation_player.play("0875")
				'11over16':
					animation_player.play("06875")
				'14over15':
					animation_player.play("09333")
				'16over25':
					animation_player.play("16over25")
				'25over16':
					animation_player.play("25over16")
				'1over20':
					animation_player.play("1over20")
				'32over25':
					animation_player.play("32over25")
				'19over16':
					animation_player.play("19over16")
				'13over20':
					animation_player.play("13over20")
