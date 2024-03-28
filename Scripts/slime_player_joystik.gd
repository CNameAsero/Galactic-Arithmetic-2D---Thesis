extends CharacterBody2D
#class_name slime_player
#
@onready var joystick = $"../Camera2D/CanvasLayer/joystick"
@onready var animation_player = $AnimationPlayer

@export var default_speed = 300
@export var speed = 300

func _physics_process(_delta):
	var direction = joystick.pos_vector
	if direction:
		velocity = direction * speed
		if direction.x > 0:
			if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
			animation_player.play("right")
		elif direction.x < 0:
			if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
			animation_player.play("left") 
		elif direction.y > 0:
			if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
			animation_player.play("down") 
		else:
			if AudioManager.is_playing_slimewalk() == false:
					AudioManager.play_slimewalk()
			animation_player.play("up") 
	else:
		animation_player.play("down")
		velocity = Vector2(0, 0)
		
	move_and_slide()

func do_teleport(area):
	for portal in get_tree().get_nodes_in_group("portal"):
		if (portal != area and portal.id == area.id and not portal.lock_portal):
			area.do_lock()
			self.global_position = portal.global_position

func _on_area_2d_area_entered(area):
	if (area.is_in_group("portal")):
		if(not area.lock_portal):
			do_teleport(area)

