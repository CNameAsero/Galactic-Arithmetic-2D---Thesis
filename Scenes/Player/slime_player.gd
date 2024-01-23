extends CharacterBody2D
class_name slime_player

@export var max_speed = 400
@export var accel = 1500
const friction = 600

var input = Vector2.ZERO
@onready var animationplayer = $AnimationPlayer
func _physics_process(delta): 
	player_movement(delta)
	update_animations()

func get_input(): #this function is for movement up right down left
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")) 
	#here i restrict the movement diagonal since the game only moves up down left right
#	if input.x != 0 and input.y != 0:
#		input.x = 0
	return input.normalized()

func player_movement(delta): #this where we move our player
	input = get_input()

	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func update_animations():
	input = get_input()

	if input == Vector2.ZERO:
		animationplayer.play("Front")
	else:
		if abs(input.x) > abs(input.y):
			if input.x > 0:
				if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
				animationplayer.play("Run-right")
			else:
				if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
				animationplayer.play("Run-Left")
		else:
			if input.y > 0:
				if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
				animationplayer.play("Front")
			else:
				if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
				animationplayer.play("Back")
