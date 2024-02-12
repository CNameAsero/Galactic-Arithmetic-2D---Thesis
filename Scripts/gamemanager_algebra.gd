extends Node2D

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
		if GameSettings.currentlevel[GameSettings.current_level - 1] and GameSettings.max_unlocked_level < GameSettings.current_level:
			GameSettings.max_unlocked_level += 1
			GameSettings.currentlevel[GameSettings.current_level] = true
		if GameSettings.current_level % 5 == 0:
			GameSettings.current_world += 1
		reset_for_next_level()
		var time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		get_tree().paused = true
	elif collected_items.size() == terms || current_result != evaluate_rpn(shunting_yard(), variables):
		AudioManager.play_deathsfx()
		reset_for_next_level()
		game_over.show()
		get_tree().paused = true

func reset_hp():
	health_system._health = 3

func restart():
	GameSettings.player_invulnerable = false
	reset_hp()
	var current_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)

func reset_for_next_level():
	GameSettings.player_invulnerable = false
	reset_hp()
	collected_items.clear()
	collected_numbers.clear()

func _ready():
	pass

func _process(_delta):
	update_expression()
