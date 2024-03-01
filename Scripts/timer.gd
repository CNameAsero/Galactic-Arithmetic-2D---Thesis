extends Node2D

@onready var timer = $Timer
@onready var timer_label = $timer_placeholder/timer_label
@onready var animation_player = $AnimationPlayer
@onready var game_manager = $".."

var time_left
var start_time
var elapsed_time = 0

func _ready():
	animation_player.play("timer")
	start_time = Time.get_ticks_msec()
	time_left = timer.wait_time
	update_timer_label()

func _process(delta):
	if timer.time_left > 0 and not get_tree().paused:
		time_left -= delta
		elapsed_time += delta
		update_timer_label()

func update_timer_label():
	@warning_ignore("integer_division")
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_timer_timeout():
	AudioManager.play_deathsfx()
	game_manager.game_over.show()
	get_tree().paused = true
	game_manager.reset_for_next_level()

func get_elapsed_time():
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	return "%02d:%02d" % [minutes, seconds]
