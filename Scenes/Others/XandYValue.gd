extends Node2D
@export var display: String

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		print("test")
		if i is Sprite2D and i.name == display:
			print("test2")
			i.visible = true
					


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
