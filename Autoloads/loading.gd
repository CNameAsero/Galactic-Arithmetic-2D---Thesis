extends Node2D

@onready var loading_scene = preload("res://Autoloads/loading.tscn")
@onready var animation_player = $loading_text/AnimationPlayer
@onready var animation_player2 = $loading_slimey/AnimationPlayer

func _ready():
	animation_player.play("loading_text")
	animation_player2.play("slimey")

func load_scene(current_scene, next_scene):
	var loading_screen_instance = loading_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_instance)
	
	var scene = ResourceLoader.load(next_scene)
	
	if scene == null:
		print("no loading!!")
		return
	
	await get_tree().create_timer(0.5).timeout
	
	var scene_instance = scene.instantiate()
	get_tree().root.call_deferred("add_child", scene_instance)
	loading_screen_instance.queue_free()
