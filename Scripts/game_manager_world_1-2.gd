extends Node2D

var collected_numbers_dict = {}
var number_scene = load("res://Scenes/Mechanics/numbers.tscn")

@onready var collected_numbers := []
@onready var collected_operators := []
@onready var current_expression := ""
@onready var isDestroy = $"bool_handler"
@onready var last_item_was_number = true

#UI
@onready var game_over = $"../menus/game_over"
@onready var level_complete_menu = $"../menus/level_complete_menu"
@onready var time_elapsed = ""

#player
@onready var player_pos = $"../slime_player_joystick/slime_player_joystik".position

#player_health
@onready var health_system = $"../health_system"

#final answer
@onready var final_answer = $final_answer.final_answer
#levels
@onready var currentlevel = 0

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1

func _ready():
	pass

func collect_number(num):
	if isDestroy.isDestroy && last_item_was_number:
		collected_numbers.append(num)
		last_item_was_number = false
	update_expression()
	check_final_answer()

func collect_operator(oper):
	if isDestroy.isDestroy && !last_item_was_number:
		collected_operators.append(oper)
		last_item_was_number = true
	update_expression()
	check_final_answer()

func update_expression():
	var numbers = []
	var operators = []
	
	for i in range(num_term):
		numbers.append("_")
	for i in range(oper_term):
		operators.append("_")

	for i in range(min(collected_numbers.size(), num_term)):
		numbers[i] = str(collected_numbers[i])

	for i in range(min(collected_operators.size(), oper_term)):
		operators[i] = str(collected_operators[i])

	current_expression = numbers[0]
	for i in range(1, num_term):
		if i <= collected_operators.size() and operators[i-1] != "_":
			current_expression += " " + operators[i-1] + " " + numbers[i]
		elif i < collected_numbers.size():
			current_expression += " _ " + numbers[i]
		else:
			current_expression += " _ _"

	$CurrentExpressionLabel.text = current_expression + " = " + str(calculate_expression())

func round_to_two_decimals(number):
	return round(number * 100.0) / 100.0

func calculate_expression():
	if collected_numbers.size() == 0:
		return 0

	var result = collected_numbers[0]
	for i in range(1, collected_numbers.size()):
		var number = collected_numbers[i]
		var oper = null
		if i - 1 < collected_operators.size():
			oper = collected_operators[i - 1]
		else:
			print("Operator index out of bounds: ", i)
			continue
		
		match oper:
			"+":
				result += number
			"-":
				result -= number
			"×":
				result *= number
			"÷":
				if number != 0:
					result = round_to_two_decimals(float(result) / number)
				else:
					print("Division by zero error")
					return 0
	return result

func check_final_answer():
	var current_result = calculate_expression()
	if current_result == final_answer:
		AudioManager.level_complete_sfx.play()
		reset_for_next_level()
		if GameSettings.current_level % 5 == 0 && !GameSettings.cutscene1 && !GameSettings.world_completed.get(GameSettings.current_level, false) && GameSettings.current_level == 5:
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.current_level % 10 == 0 && !GameSettings.cutscene2 && !GameSettings.world_completed.get(GameSettings.current_level, false) && GameSettings.current_level == 10:
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.currentlevel[GameSettings.current_level - 1] and GameSettings.max_unlocked_level < GameSettings.current_level:
			GameSettings.max_unlocked_level += 1
			GameSettings.currentlevel[GameSettings.current_level] = true
		time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		GameSettings.player_invulnerable = false
		GameSettings._autosave()
		get_tree().paused = true
	elif collected_numbers.size() == num_term || current_result != calculate_expression():
		AudioManager.play_deathsfx()
		reset_for_next_level()
		game_over.show()
		get_tree().paused = true

func reset_player_position():
	$"../Slime_player".position = player_pos

func restart():
	GameSettings.player_invulnerable = false
	reset_hp()
	
	var rng = RandomNumberGenerator.new()
	var scenes = []
	
	if GameSettings.current_level == 1:
		scenes = ["res://Scenes/levels/level_1.tscn", "res://Scenes/levels/level_1_1.tscn", "res://Scenes/levels/level_1_2.tscn"]
	elif GameSettings.current_level == 2:
		scenes = ["res://Scenes/levels/level_2.tscn", "res://Scenes/levels/level_2_1.tscn", "res://Scenes/levels/level_2_2.tscn"]
	elif GameSettings.current_level == 3:
		scenes = ["res://Scenes/levels/level_3.tscn", "res://Scenes/levels/level_3_1.tscn", "res://Scenes/levels/level_3_2.tscn"]
	elif GameSettings.current_level == 4:
		scenes = ["res://Scenes/levels/level_4.tscn", "res://Scenes/levels/level_4_1.tscn", "res://Scenes/levels/level_4_2.tscn"]
	elif GameSettings.current_level == 5:
		scenes = ["res://Scenes/levels/level_5.tscn", "res://Scenes/levels/level_5_1.tscn", "res://Scenes/levels/level_5_2.tscn"]
	elif GameSettings.current_level == 6:
		scenes = ["res://Scenes/levels/level_6.tscn", "res://Scenes/levels/level_6_1.tscn", "res://Scenes/levels/level_6_2.tscn"]
	elif GameSettings.current_level == 7:
		scenes = ["res://Scenes/levels/level_7.tscn", "res://Scenes/levels/level_7_1.tscn", "res://Scenes/levels/level_7_2.tscn"]
	elif GameSettings.current_level == 8:
		scenes = ["res://Scenes/levels/level_8.tscn", "res://Scenes/levels/level_8_1.tscn", "res://Scenes/levels/level_8_2.tscn"]
	elif GameSettings.current_level == 9:
		scenes = ["res://Scenes/levels/level_9.tscn", "res://Scenes/levels/level_9_1.tscn", "res://Scenes/levels/level_9_2.tscn"]
	elif GameSettings.current_level == 10:
		scenes = ["res://Scenes/levels/level_10.tscn", "res://Scenes/levels/level_10_1.tscn", "res://Scenes/levels/level_10_2.tscn"]
	var random_index = rng.randi_range(0, scenes.size() - 1)
	var random_scene = scenes[random_index]
	get_tree().change_scene_to_file(random_scene)

func save_collectible_number(collectible):
	var collectible_number = {
		"value": collectible.number,
		"position": collectible.global_position
	}
	collected_numbers_dict[collectible.name] = collectible_number

func clear_eq():
	collected_numbers.clear()
	collected_operators.clear()
	last_item_was_number = true
	for collectible_name in collected_numbers_dict:
		var collectible_info = collected_numbers_dict[collectible_name]
		var new_collectible = number_scene.instantiate()
		new_collectible.number = collectible_info["value"]
		new_collectible.global_position = collectible_info["position"]
		add_child(new_collectible)
	collected_numbers_dict.clear()

func reset_for_next_level():
	reset_hp()
	collected_numbers.clear()
	collected_operators.clear()
	GameSettings.player_invulnerable = false

func _on_timer_timeout():
	AudioManager.play_deathsfx()
	game_over.show()
	get_tree().paused = true
	reset_for_next_level()

func reset_hp():
	health_system._health = 3

func _process(_delta):
	update_expression()
