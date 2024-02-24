extends Area2D

@onready var number_to_display = $"..".number
@onready var access_manager = $"../.."

func _ready():
	for i in get_children():
		if i is Sprite2D and i.name == str(number_to_display):
			i.visible = true
			match number_to_display:
				0:
					var animationplayer0 = $"0/AnimationPlayer"
					animationplayer0.play("Shining")
				1:
					var animationplayer1 = $"1/AnimationPlayer"
					animationplayer1.play("Shining")
				2:
					var animationplayer2 = $"2/AnimationPlayer"
					animationplayer2.play("Shining")
				3:
					var animationplayer3 = $"3/AnimationPlayer"
					animationplayer3.play("Shining")
				4:
					var animationplayer4 = $"4/AnimationPlayer"
					animationplayer4.play("Shining")
				5:
					var animationplayer5 = $"5/AnimationPlayer"
					animationplayer5.play("Shining")
				6:
					var animationplayer6 = $"6/AnimationPlayer"
					animationplayer6.play("Shining")
				7:
					var animationplayer7 = $"7/AnimationPlayer"
					animationplayer7.play("Shining")
				8:
					var animationplayer8 = $"8/AnimationPlayer"
					animationplayer8.play("Shining")
				9:
					var animationplayer9 = $"9/AnimationPlayer"
					animationplayer9.play("Shining")
				10:
					var animationplayer10 = $"10/AnimationPlayer"
					animationplayer10.play("Shining")
				12:
					var animationplayer12 = $"12/AnimationPlayer"
					animationplayer12.play("Shining")
				13:
					var animationplayer13 = $"13/AnimationPlayer"
					animationplayer13.play("Shining")
				14:
					var animationplayer14 = $"14/AnimationPlayer"
					animationplayer14.play("Shining")
				16:
					var animationplayer16 = $"16/AnimationPlayer"
					animationplayer16.play("Shining")
				17:
					var animationplayer17 = $"17/AnimationPlayer"
					animationplayer17.play("Shining")
				19:
					var animationplayer19 = $"19/AnimationPlayer"
					animationplayer19.play("Shining")
				20:
					var animationplayer20 = $"20/AnimationPlayer"
					animationplayer20.play("Shining")
				24:
					var animationplayer24 = $"24/AnimationPlayer"
					animationplayer24.play("Shining")
				30:
					var animationplayer30 = $"30/AnimationPlayer"
					animationplayer30.play("Shining")
				54:
					var animationplayer54 = $"54/AnimationPlayer"
					animationplayer54.play("Shining")
				56:
					var animationplayer56 = $"56/AnimationPlayer"
					animationplayer56.play("Shining")
		else:
			i.visible = false

func _on_body_entered(body):
	if body.is_in_group("player") && !access_manager.last_item_was_number:
		AudioManager.play_item_collect()
		access_manager.isDestroy = true
		access_manager.collect_number(number_to_display)
		access_manager.save_collectible_number($"..")
		$"..".queue_free()
