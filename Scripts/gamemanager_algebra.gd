extends Node2D

var collected_numbers_dict = {}
var number_scene = load("res://Scenes/Mechanics/numbers_w5.tscn")

var collected_variables_dict = {}
var variable_scene = load("res://Scenes/Mechanics/variables_w5.tscn")

var last_item_was_number = false
var last_item_was_variable = false
var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2, "^": 3}

@onready var collected_variables := []
@onready var collected_numbers := []
@onready var collected_items := []
@onready var isDestroy = false

@export_category("how many terms?")
@export var num_term : int
@export var variable_term : int
@onready var oper_term = num_term - 1
@onready var terms = num_term + oper_term + variable_term

@export_category("values")
@export var x_value : int
@export var y_value : int

@onready var  variables = {"x": x_value, "y": y_value}
@onready var health_system = $"../health_system"
@onready var final_answer = $final_answer_w5.final_answer
@onready var level_complete_menu = $"../menus/level_complete_menu"
@onready var game_over = $"../menus/game_over"

func collect_number(num):
	if isDestroy && !last_item_was_number:
		collected_items.append(num)
		collected_numbers.append(num)
		last_item_was_number = true
	update_expression()
	check_final_answer()

func collect_operator(oper):
	if isDestroy && last_item_was_number && last_item_was_variable:
		collected_items.append(oper)
		last_item_was_number = false
		last_item_was_variable = false
	update_expression()
	check_final_answer()

func collect_variable(varia):
	if isDestroy && !last_item_was_variable && last_item_was_number:
			collected_items.append(varia)
			collected_variables.append(varia)
			last_item_was_number = true
			last_item_was_variable = true
	update_expression()
	check_final_answer()

func shunting_yard():
	var output_queue = []
	var operator_stack = []

	for item in collected_items:
		if typeof(item) == TYPE_INT or item in variables:
			output_queue.append(item)
		elif item in precedence:
			while operator_stack and operator_stack.back() in precedence and precedence[item] <= precedence[operator_stack.back()]:
				output_queue.append(operator_stack.pop_back())
			operator_stack.append(item)

	while operator_stack:
		output_queue.append(operator_stack.pop_back())

	return output_queue

func evaluate_rpn(expression, variables):
	if expression.size() == 0:
		return 0
	var stack = []
	for token in expression:
		if typeof(token) == TYPE_INT:
			stack.append(token)
		elif token in variables:
			if !stack.is_empty():
				var num1 = stack.pop_back()
				stack.append(num1 * variables[token])
			else:
				stack.append(variables[token])
		elif token in precedence:
			if stack.size() < 2:
				return 0
			var num2 = stack.pop_back()
			var num1 = stack.pop_back()
			if token == "+":
				stack.append(num1 + num2)
			elif token == "-":
				stack.append(num1 - num2)
			elif token == "×":
				stack.append(num1 * num2)
			elif token == "÷":
				if num2 == 0:
					return 0
				stack.append(num1 / num2)
			elif token == "^":
				stack.append(pow(num1, num2))
	if stack.size() > 0:
		return stack[0]
	else:
		return 0

func update_expression():
	var items = []

	for i in range(num_term + oper_term + variable_term):
		if i < collected_items.size():
			items.append(str(collected_items[i]))
		else:
			items.append("_")

	var current_expression = ""
	for i in range(items.size()):
		current_expression += items[i] + " "

	$"1st_label".text = current_expression + " = " + str(evaluate_rpn(shunting_yard(), variables))

func check_final_answer():
	var current_level = 0
	var current_result = evaluate_rpn(shunting_yard(), variables)
	if str(current_result) == str(final_answer):
		AudioManager.level_complete_sfx.play()
		if GameSettings.current_level % 5 == 0 && !GameSettings.finalcutscene && !GameSettings.world_completed.get(GameSettings.current_level, false) && GameSettings.current_level == 25:
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.currentlevel[GameSettings.current_level - 1] and GameSettings.max_unlocked_level < GameSettings.current_level:
			GameSettings.max_unlocked_level += 1
			GameSettings.currentlevel[GameSettings.current_level] = true
		reset_for_next_level()
		var time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		GameSettings.player_invulnerable = false
		GameSettings._autosave()
		get_tree().paused = true
	elif collected_items.size() == terms || current_result != evaluate_rpn(shunting_yard(), variables):
		AudioManager.play_deathsfx()
		reset_for_next_level()
		game_over.show()
		get_tree().paused = true

func reset_hp():
	health_system._health = 5

func restart():
	GameSettings.player_invulnerable = false
	reset_hp()
	
	var rng = RandomNumberGenerator.new()
	var scenes = []
	
	if GameSettings.current_level == 21:
		scenes = ["res://Scenes/levels/level_21.tscn", "res://Scenes/levels/level_21_1.tscn", "res://Scenes/levels/level_21_2.tscn"]
	elif GameSettings.current_level == 22:
		scenes = ["res://Scenes/levels/level_22.tscn", "res://Scenes/levels/level_22_1.tscn", "res://Scenes/levels/level_22_2.tscn"]
	elif GameSettings.current_level == 23:
		scenes = ["res://Scenes/levels/level_23.tscn", "res://Scenes/levels/level_23_1.tscn", "res://Scenes/levels/level_23_2.tscn"]
	elif GameSettings.current_level == 24:
		scenes = ["res://Scenes/levels/level_24.tscn", "res://Scenes/levels/level_24_1.tscn", "res://Scenes/levels/level_24_2.tscn"]
	elif GameSettings.current_level == 25:
		scenes = ["res://Scenes/levels/level_25.tscn", "res://Scenes/levels/level_25_1.tscn", "res://Scenes/levels/level_25_2.tscn"]

	var random_index = rng.randi_range(0, scenes.size() - 1)
	var random_scene = scenes[random_index]
	get_tree().change_scene_to_file(random_scene)

func save_collectible_number(collectible):
	var collectible_number = {
		"value": collectible.number,
		"position": collectible.global_position
	}
	collected_numbers_dict[collectible] = collectible_number

func save_collectible_variable(collectible):
	var collectible_variable = {
		"value": collectible.variable_to_display,
		"position": collectible.global_position
		
	}
	collected_variables_dict[collectible] = collectible_variable

func clear_eq():
	collected_items.clear()
	collected_variables.clear()
	collected_numbers.clear()
	last_item_was_number = false
	last_item_was_variable = false

	for collectible_name in collected_numbers_dict:
		var collectible_info = collected_numbers_dict[collectible_name]
		var new_collectible = number_scene.instantiate()
		new_collectible.number = collectible_info["value"]
		new_collectible.global_position = collectible_info["position"]
		add_child(new_collectible)

	for collectible_name in collected_variables_dict:
		var collectible_info = collected_variables_dict[collectible_name]
		var new_collectible = variable_scene.instantiate()
		new_collectible.variable_to_display = collectible_info["value"]
		new_collectible.global_position = collectible_info["position"]
		add_child(new_collectible)

	collected_numbers_dict.clear()
	collected_variables_dict.clear()

func reset_for_next_level():
	GameSettings.player_invulnerable = false
	reset_hp()
	collected_items.clear()
	collected_numbers.clear()

func _ready():
	GameSettings.isHard = true

func _process(_delta):
	update_expression()
