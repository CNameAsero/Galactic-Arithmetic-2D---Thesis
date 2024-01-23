extends TextureButton

var time = 0
var sinTime = 0
var _visible = true
var speed = 5
var fade = true

func flashMyText():
	if !fade:
		if sinTime > 0:
			_visible = true
		else:
			_visible = false
	else:
		_visible = true
		modulate.a = sinTime
		pass

func _physics_process(delta):
	time += delta
	sinTime = sin(time*speed)
	flashMyText()

