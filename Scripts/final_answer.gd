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
				1:
					var animationplayer1 = $"1/AnimationPlayer"
					animationplayer1.play("chest")
				3:
					var animationplayer3 = $"3/AnimationPlayer"
					animationplayer3.play("chest")
				10:
					var animationplayer10 = $"10/AnimationPlayer"
					animationplayer10.play("chest")
				11:
					var animationplayer11 = $"11/AnimationPlayer"
					animationplayer11.play("chest")
				16:
					var animationplayer16 = $"16/AnimationPlayer"
					animationplayer16.play("chest")
				19:
					var animationplayer19 = $"19/AnimationPlayer"
					animationplayer19.play("chest")
				21:
					var animationplayer21 = $"21/AnimationPlayer"
					animationplayer21.play("chest")
				24:
					var animationplayer24 = $"24/AnimationPlayer"
					animationplayer24.play("chest")
				32:
					var animationplayer32 = $"32/AnimationPlayer"
					animationplayer32.play("chest")
				37:
					var animationplayer37 = $"37/AnimationPlayer"
					animationplayer37.play("chest")
				38:
					var animationplayer38 = $"38/AnimationPlayer"
					animationplayer38.play("chest")
				48:
					var animationplayer48 = $"48/AnimationPlayer"
					animationplayer48.play("chest")
				52:
					var animationplayer52 = $"52/AnimationPlayer"
					animationplayer52.play("chest")
				72:
					var animationplayer72 = $"72/AnimationPlayer"
					animationplayer72.play("chest")

		else:
			i.visible = false
