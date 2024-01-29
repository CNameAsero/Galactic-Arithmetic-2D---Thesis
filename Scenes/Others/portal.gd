extends Area2D

@export var id = 0

@onready var animation_player = $AnimationPlayer

var lock_portal = false

func _ready():
	animation_player.play("in")

func do_lock():
	lock_portal = true
	await get_tree().create_timer(0.3).timeout
	lock_portal = false
