extends Node

var Master_bus = AudioServer.get_bus_index("Master")
var Music_bus = AudioServer.get_bus_index("music")
var Sfx_bus = AudioServer.get_bus_index("sfx")

var level1_music: AudioStreamPlayer
var background_music: AudioStreamPlayer
var button_sfx: AudioStreamPlayer
var death_sfx: AudioStreamPlayer
var slime_walk: AudioStreamPlayer
var item_collect_sfx: AudioStreamPlayer
var operator_collect: AudioStreamPlayer
var level_complete_sfx: AudioStreamPlayer
var slime_hurt : AudioStreamPlayer
var octopus : AudioStreamPlayer
var teleport : AudioStreamPlayer
var tutorial1 : AudioStreamPlayer
var tutorial2 : AudioStreamPlayer
var tutorial3 : AudioStreamPlayer
var tutorial4 : AudioStreamPlayer
var tutorial5 : AudioStreamPlayer
var tutorial6 : AudioStreamPlayer
var tutorial7 : AudioStreamPlayer

var is_music_muted = false #bg music menu
var is_level1music_muted = false #bg music level1
var is_sfx_muted = false
var music_position: float

func _ready():
	level1_music = $Level1_Music
	background_music = $BG_Music
	button_sfx = $Button_SFX
	death_sfx = $death_sfx
	slime_walk = $slime_walk
	item_collect_sfx = $item_collect
	operator_collect = $operator_collect
	level_complete_sfx = $level_complete_sfx
	slime_hurt = $slime_hurt
	octopus = $octopus_shot
	teleport = $teleport
	tutorial1 = $"6th_tutorial"
	tutorial2 = $"1st_tutorial"
	tutorial3 = $"2nd_tutorial"
	tutorial4 = $"3rd_tutorial"
	tutorial5 = $"4th_tutorial"
	tutorial6 = $"5th_tutorial"
	tutorial7 = $"7th_tutorial"
func play_button_sfx():
	button_sfx.play()

func play_deathsfx():
	death_sfx.play()

func play_slimewalk():
	slime_walk.play()

func is_playing_slimewalk() -> bool:
	return slime_walk.playing

func play_item_collect():
	item_collect_sfx.play()

func play_operator_collect():
	operator_collect.play()

func player_hurt():
	slime_hurt.play()

func octopus_shot():
	octopus.play()

func tele():
	teleport.play()


# TUTORIAL VOICE OVER
func tuto1():
	tutorial1.play()
func tuto1_stop():
	tutorial1.stop()
func tuto2():
	tutorial2.play()
func tuto2_stop():
	tutorial2.stop()
func tuto3():
	tutorial3.play()
func tuto3_stop():
	tutorial3.stop()
func tuto4():
	tutorial4.play()
func tuto4_stop():
	tutorial4.stop()
func tuto5():
	tutorial5.play()
func tuto5_stop():
	tutorial5.stop()
func tuto6():
	tutorial6.play()
func tuto6_stop():
	tutorial6.stop()
func tuto7():
	tutorial7.play()
func tuto7_stop():
	tutorial7.stop()
