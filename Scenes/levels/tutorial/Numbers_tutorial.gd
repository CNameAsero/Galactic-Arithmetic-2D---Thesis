extends Area2D

@export var number_to_display : int
@onready var access_manager = $"../../"
@onready var access_bool = $"../../bool_handler"

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
		else:
			i.visible = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.play_item_collect()
		access_bool.isDestroy = true
		access_manager.collect_number(number_to_display)
		queue_free()
