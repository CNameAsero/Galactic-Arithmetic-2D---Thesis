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
