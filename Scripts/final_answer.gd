extends CharacterBody2D

@export var final_answer = 0

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == str(final_answer):
			i.visible = true
			match final_answer:
				1:
					var animationplayer1 = $"1/AnimationPlayer"
					animationplayer1.play("chest")
				2:
					var animationplayer2 = $"2/AnimationPlayer"
					animationplayer2.play("chest")
				3:
					var animationplayer3 = $"3/AnimationPlayer"
					animationplayer3.play("chest")
				4:
					var animationplayer4 = $"4/AnimationPlayer"
					animationplayer4.play("chest")
				5:
					var animationplayer5 = $"5/AnimationPlayer"
					animationplayer5.play("chest")
				9:
					var animationplayer9 = $"9/AnimationPlayer"
					animationplayer9.play("chest")
				10:
					var animationplayer10 = $"10/AnimationPlayer"
					animationplayer10.play("chest")
				11:
					var animationplayer11 = $"11/AnimationPlayer"
					animationplayer11.play("chest")
				16:
					var animationplayer16 = $"16/AnimationPlayer"
					animationplayer16.play("chest")
				17:
					var animationplayer17 = $"17/AnimationPlayer"
					animationplayer17.play("chest")
				19:
					var animationplayer19 = $"19/AnimationPlayer"
					animationplayer19.play("chest")
				21:
					var animationplayer21 = $"21/AnimationPlayer"
					animationplayer21.play("chest")
				22:
					var animationplayer22 = $"22/AnimationPlayer"
					animationplayer22.play("chest")
				24:
					var animationplayer24 = $"24/AnimationPlayer"
					animationplayer24.play("chest")
				32:
					var animationplayer32 = $"32/AnimationPlayer"
					animationplayer32.play("chest")
				34:
					var animationplayer34 = $"34/AnimationPlayer"
					animationplayer34.play("chest")
				35:
					var animationplayer35 = $"35/AnimationPlayer"
					animationplayer35.play("chest")
				36:
					var animationplayer36 = $"36/AnimationPlayer"
					animationplayer36.play("chest")
				37:
					var animationplayer37 = $"37/AnimationPlayer"
					animationplayer37.play("chest")
				38:
					var animationplayer38 = $"38/AnimationPlayer"
					animationplayer38.play("chest")
				39:
					var animationplayer39 = $"39/AnimationPlayer"
					animationplayer39.play("chest")
				42:
					var animationplayer42 = $"42/AnimationPlayer"
					animationplayer42.play("chest")
				48:
					var animationplayer48 = $"48/AnimationPlayer"
					animationplayer48.play("chest")
				51:
					var animationplayer51 = $"51/AnimationPlayer"
					animationplayer51.play("chest")
				52:
					var animationplayer52 = $"52/AnimationPlayer"
					animationplayer52.play("chest")
				53:
					var animationplayer53 = $"53/AnimationPlayer"
					animationplayer53.play("chest")
				72:
					var animationplayer72 = $"72/AnimationPlayer"
					animationplayer72.play("chest")
				80:
					var animationplayer80 = $"80/AnimationPlayer"
					animationplayer80.play("chest")
				84:
					var animationplayer84 = $"84/AnimationPlayer"
					animationplayer84.play("chest")
		else:
			i.visible = false
