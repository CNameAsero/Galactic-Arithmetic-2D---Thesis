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
var story18 : AudioStreamPlayer

##CUTSCENE 1
@onready var cut1_1 = $cut1_1
@onready var cut1_2 = $cut1_2
@onready var cut1_3 = $cut1_3
@onready var cut1_4 = $cut1_4
@onready var cut1_5 = $cut1_5
@onready var cut1_6 = $cut1_6
@onready var cut1_7 = $cut1_7

@onready var cut2_1 = $cut2_1
@onready var cut2_2 = $cut2_2
@onready var cut2_3 = $cut2_3
@onready var cut2_4 = $cut2_4
@onready var cut2_5 = $cut2_5
@onready var cut2_6 = $cut2_6
@onready var cut2_7 = $cut2_7

@onready var cut3_1 = $cut3_1
@onready var cut3_2 = $cut3_2
@onready var cut3_3 = $cut3_3
@onready var cut3_4 = $cut3_4
@onready var cut3_5 = $cut3_5
@onready var cut3_6 = $cut3_6
@onready var cut3_7 = $cut3_7

@onready var cut4_1 = $cut4_1
@onready var cut4_2 = $cut4_2
@onready var cut4_3 = $cut4_3
@onready var cut4_4 = $cut4_4
@onready var cut4_5 = $cut4_5
@onready var cut4_6 = $cut4_6
@onready var cut4_7 = $cut4_7


@onready var finalcut1 = $finalcut1
@onready var finalcut2 = $finalcut2
@onready var finalcut3 = $finalcut3
@onready var finalcut4 = $finalcut4
@onready var finalcut5 = $finalcut5
@onready var finalcut6 = $finalcut6
@onready var finalcut7 = $finalcut7
@onready var finalcut8 = $finalcut8
@onready var finalcut9 = $finalcut9
@onready var finalcut10 = $finalcut10
@onready var finalcut11 = $finalcut11
@onready var finalcut12 = $finalcut12
@onready var finalcut13 = $finalcut13
@onready var finalcut14 = $finalcut14
@onready var finalcut15 = $finalcut15
@onready var finalcut16 = $finalcut16
@onready var finalcut17 = $finalcut17
@onready var finalcut18 = $finalcut18
@onready var finalcut19 = $finalcut19
@onready var finalcut20 = $finalcut20


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
	story17 = $story17
	story18 = $story18

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
func sto1():
	story1.play()
func sto1_stop():
	story1.stop()
func sto2():
	story2.play()
func sto2_stop():
	story2.stop()
func sto3():
	story3.play()
func sto3_stop():
	story3.stop()
func sto4():
	story4.play()
func sto4_stop():
	story4.stop()
func sto5():
	story5.play()
func sto5_stop():
	story5.stop()
func sto6():
	story6.play()
func sto6_stop():
	story6.stop()
func sto7():
	story7.play()
func sto7_stop():
	story7.stop()
func sto8():
	story8.play()
func sto8_stop():
	story8.stop()
func sto9():
	story9.play()
func sto9_stop():
	story9.stop()
func sto10():
	story10.play()
func sto10_stop():
	story10.stop()
func sto11():
	story11.play()
func sto11_stop():
	story11.stop()
func sto12():
	story12.play()
func sto12_stop():
	story12.stop()
func sto13():
	story13.play()
func sto13_stop():
	story13.stop()
func sto14():
	story14.play()
func sto14_stop():
	story14.stop()
func sto15():
	story15.play()
func sto15_stop():
	story15.stop()
func sto16():
	story16.play()
func sto16_stop():
	story16.stop()
func sto17():
	story17.play()
func sto17_stop():
	story17.stop()
func sto18():
	story18.play()
func sto18_stop():
	story18.stop()

#CUTSCENE 1
func cut1():
	cut1_1.play()
func cut1_stop():
	cut1_1.stop()
func cut2():
	cut1_2.play()
func cut2_stop():
	cut1_2.stop()
func cut3():
	cut1_3.play()
func cut3_stop():
	cut1_3.stop()
func cut4():
	cut1_4.play()
func cut4_stop():
	cut1_4.stop()
func cut5():
	cut1_5.play()
func cut5_stop():
	cut1_5.stop()
func cut6():
	cut1_6.play()
func cut6_stop():
	cut1_6.stop()
func cut7():
	cut1_7.play()
func cut7_stop():
	cut1_7.stop()

func cutt1():
	cut2_1.play()
func cutt1_stop():
	cut2_1.stop()
func cutt2():
	cut2_2.play()
func cutt2_stop():
	cut2_2.stop()
func cutt3():
	cut2_3.play()
func cutt3_stop():
	cut2_3.stop()
func cutt4():
	cut2_4.play()
func cutt4_stop():
	cut2_4.stop()
func cutt5():
	cut2_5.play()
func cutt5_stop():
	cut2_5.stop()
func cutt6():
	cut2_6.play()
func cutt6_stop():
	cut2_6.stop()
func cutt7():
	cut2_7.play()
func cutt7_stop():
	cut2_7.stop()


func cuttt1():
	cut3_1.play()
func cuttt1_stop():
	cut3_1.stop()
func cuttt2():
	cut3_2.play()
func cuttt2_stop():
	cut3_2.stop()
func cuttt3():
	cut3_3.play()
func cuttt3_stop():
	cut3_3.stop()
func cuttt4():
	cut3_4.play()
func cuttt4_stop():
	cut3_4.stop()
func cuttt5():
	cut3_5.play()
func cuttt5_stop():
	cut3_5.stop()
func cuttt6():
	cut3_6.play()
func cuttt6_stop():
	cut3_6.stop()
func cuttt7():
	cut3_7.play()
func cuttt7_stop():
	cut3_7.stop()

func cutttt1():
	cut4_1.play()
func cutttt1_stop():
	cut4_1.stop()
func cutttt2():
	cut4_2.play()
func cutttt2_stop():
	cut4_2.stop()
func cutttt3():
	cut4_3.play()
func cutttt3_stop():
	cut4_3.stop()
func cutttt4():
	cut4_4.play()
func cutttt4_stop():
	cut4_4.stop()
func cutttt5():
	cut4_5.play()
func cutttt5_stop():
	cut4_5.stop()
func cutttt6():
	cut4_6.play()
func cutttt6_stop():
	cut4_6.stop()
func cutttt7():
	cut4_7.play()
func cutttt7_stop():
	cut4_7.stop()

func final_cut1():
	finalcut1.play()
func final_cut1_stop():
	finalcut1.stop()
func final_cut2():
	finalcut2.play()
func final_cut2_stop():
	finalcut2.stop()
func final_cut3():
	finalcut3.play()
func final_cut3_stop():
	finalcut3.stop()
func final_cut4():
	finalcut4.play()
func final_cut4_stop():
	finalcut4.stop()
func final_cut5():
	finalcut5.play()
func final_cut5_stop():
	finalcut5.stop()
func final_cut6():
	finalcut6.play()
func final_cut6_stop():
	finalcut6.stop()
func final_cut7():
	finalcut7.play()
func final_cut7_stop():
	finalcut7.stop()
func final_cut8():
	finalcut8.play()
func final_cut8_stop():
	finalcut8.stop()
func final_cut9():
	finalcut9.play()
func final_cut9_stop():
	finalcut9.stop()
func final_cut10():
	finalcut10.play()
func final_cut10_stop():
	finalcut10.stop()
func final_cut11():
	finalcut11.play()
func final_cut11_stop():
	finalcut11.stop()
func final_cut12():
	finalcut12.play()
func final_cut12_stop():
	finalcut12.stop()
func final_cut13():
	finalcut13.play()
func final_cut13_stop():
	finalcut13.stop()
func final_cut14():
	finalcut14.play()
func final_cut14_stop():
	finalcut14.stop()
func final_cut15():
	finalcut15.play()
func final_cut15_stop():
	finalcut15.stop()
func final_cut16():
	finalcut16.play()
func final_cut16_stop():
	finalcut16.stop()
func final_cut17():
	finalcut17.play()
func final_cut17_stop():
	finalcut17.stop()
func final_cut18():
	finalcut18.play()
func final_cut18_stop():
	finalcut18.stop()
func final_cut19():
	finalcut19.play()
func final_cut19_stop():
	finalcut19.stop()
func final_cut20():
	finalcut20.play()
func final_cut20_stop():
	finalcut20.stop()
