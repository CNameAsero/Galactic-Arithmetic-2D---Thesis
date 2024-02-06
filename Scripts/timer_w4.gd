extends Node2D

@onready var timer = $Timer
@onready var timer_label = $timer_placeholder/timer_label
@onready var animation_player = $AnimationPlayer
@onready var gamemanager = $".."

var time_left
var start_time

func _ready():
	animation_player.play("timer")
	start_time = Time.get_ticks_msec()
	time_left = timer.wait_time
	update_timer_label()

func _process(delta):
	if timer.time_left > 0:
		time_left -= delta
		update_timer_label()

func update_timer_label():
	@warning_ignore("integer_division")
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_timer_timeout():
	AudioManager.play_deathsfx()
	gamemanager.game_over.show()
	get_tree().paused = true
	gamemanager.reset_for_next_level()

func get_elapsed_time():
	var elapsed_time = (Time.get_ticks_msec() - start_time) / 1000
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	return "%02d:%02d" % [minutes, seconds]
