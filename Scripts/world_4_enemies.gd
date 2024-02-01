extends Node2D

@export_category("type (lava, bat, skeleton)")
@export var enemy_type : String

var angle = 50
var speed = 0.1 * PI / 180
@export_category("bat")
@export var move_speed : float
@export var  radius = 250
@export var rect_radius_bat : float

@export_category("skeleton")
@export var skeleton_speed : float
@export var rect_radius_skeleton : float
@export var move_direction : Vector2
@export var ammo_skeleton : PackedScene

var start_pos : Vector2
var target_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	target_pos = start_pos + move_direction

	for i in get_children():
		if i is Area2D and i.name == enemy_type:
			i.visible = true
			if enemy_type == "ice":
				if i.name == "ice":
					$bear.queue_free()
					$yeti.queue_free()
			elif enemy_type == "bear":
				#area_radius_bat()
				if i.name == "bear":
					$ice.queue_free()
					$yeti.queue_free()
			elif enemy_type == "yeti":
				#area_radius_skeleton()
				if i.name == "yeti":
					$ice.queue_free()
					$bear.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
