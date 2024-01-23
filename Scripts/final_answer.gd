extends CharacterBody2D
class_name finalanswer

@export var final_answer = 0

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == str(final_answer):
			i.visible = true
			match final_answer:
				0:
					pass
				10:
					var animationplayer10 = $"10/AnimationPlayer"
					animationplayer10.play("10chest")
				19:
					var animationplayer19 = $"19/AnimationPlayer"
					animationplayer19.play("chest_movement")
				3:
					var animationplayer3 = $"3/AnimationPlayer"
					animationplayer3.play("3chest")
				11:
					var animationplayer11 = $"11/AnimationPlayer"
					animationplayer11.play("11chest")
				32:
					var animationplayer32 = $"32/AnimationPlayer"
					animationplayer32.play("32chest")
		else:
			i.visible = false
