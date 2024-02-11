extends Node

var Master_bus = AudioServer.get_bus_index("Master")
var Music_bus = AudioServer.get_bus_index("music")
var Sfx_bus = AudioServer.get_bus_index("sfx")

var level1_music: AudioStreamPlayer
var level2_music: AudioStreamPlayer
var level3_music: AudioStreamPlayer
var level4_music: AudioStreamPlayer
var level5_music: AudioStreamPlayer

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

var story1 : AudioStreamPlayer
var story2 : AudioStreamPlayer
var story3 : AudioStreamPlayer
var story4 : AudioStreamPlayer
var story5 : AudioStreamPlayer
var story6 : AudioStreamPlayer
var story7 : AudioStreamPlayer
var story8 : AudioStreamPlayer
var story9 : AudioStreamPlayer
var story10 : AudioStreamPlayer
var story11 : AudioStreamPlayer
var story12 : AudioStreamPlayer
var story13 : AudioStreamPlayer
var story14 : AudioStreamPlayer
var story15 : AudioStreamPlayer
var story16 : AudioStreamPlayer
var story17 : AudioStreamPlayer
var is_music_muted = false #bg music menu
var is_level1music_muted = false #bg music level1
var is_sfx_muted = false
var music_position: float

func _ready():
	#WORLD 1 - 5 MUSIC
	level1_music = $Level1_Music
	level2_music = $Level2_Music
	level3_music = $Level3_Music
	level4_music = $Level4_Music
	level5_music = $Level5_Music
	
	#SOUND EFFECTS
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


	#TUTORIAL
	tutorial1 = $"6th_tutorial"
	tutorial2 = $"1st_tutorial"
	tutorial3 = $"2nd_tutorial"
	tutorial4 = $"3rd_tutorial"
	tutorial5 = $"4th_tutorial"
	tutorial6 = $"5th_tutorial"
	tutorial7 = $"7th_tutorial"

	#STORY BOARD
	story1 = $story1
	story2 = $story2
	story3 = $story3
	story4 = $story4
	story5 = $story5
	story6 = $story6
	story7 = $story7
	story8 = $story8
	story9 = $story9
	story10 = $story10
	story11 = $story11
	story12 = $story12
	story13 = $story13
	story14 = $story14
	story15 = $story15
	story16 = $story16

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

# STORY BOARD VOICE OVER
func sto2():
	story1.play()
func sto2_stop():
	story1.stop()
func sto3():
	story2.play()
func sto3_stop():
	story2.stop()
func sto4():
	story3.play()
func sto4_stop():
	story3.stop()
func sto5():
	story4.play()
func sto5_stop():
	story4.stop()
func sto6():
	story5.play()
func sto6_stop():
	story5.stop()
func sto7():
	story6.play()
func sto7_stop():
	story6.stop()
func sto8():
	story7.play()
func sto8_stop():
	story7.stop()
func sto9():
	story8.play()
func sto9_stop():
	story8.stop()
func  sto10():
	story9.play()
func  sto10_stop():
	story9.stop()
func sto11():
	story10.play()
func sto11_stop():
	story10.stop()
func sto12():
	story11.play()
func sto12_stop():
	story11.stop()
func sto13():
	story12.play()
func sto13_stop():
	story12.stop()
func sto14():
	story13.play()
func sto14_stop():
	story13.stop()
func sto15():
	story14.play()
func sto15_stop():
	story14.stop()
func sto16():
	story15.play()
func sto16_stop():
	story15.stop()
func sto17():
	story16.play()
func sto17_stop():
	story16.stop()
