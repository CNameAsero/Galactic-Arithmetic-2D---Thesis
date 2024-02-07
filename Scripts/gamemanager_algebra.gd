extends Node2D

var last_item_was_number = false
var can_collect_fraction = true
var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2,"^": 3}

@onready var collected_variables := []
@onready var collected_items := []
@onready var isDestroy = false
@onready var open = false
@onready var label = $"1st_label"

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1
@export var var_term : int
@onready var terms = num_term + oper_term
@onready var health_system = $"../health_system"

#@onready var final_answer = $final_answer_w4.final_answer
@onready var level_complete_menu = $"../menus/level_complete_menu"
@onready var game_over = $"../menus/game_over"

func collect_number(num):
	if isDestroy && !last_item_was_number:
		collected_items.append(num)
		last_item_was_number = true
	update_expression()
#	check_final_answer()

func collect_operator(oper):
	if isDestroy && last_item_was_number:
		collected_items.append(oper)
		last_item_was_number = false
	update_expression()
#	check_final_answer()

func collect_variable(varia):
	if isDestroy && last_item_was_number:
		collected_items.append(varia)
		last_item_was_number = true
	update_expression()
#	check_final_answer()

func shunting_yard():
	var output_queue = []
	var operator_stack = []

	for item in collected_items:
		if typeof(item) == TYPE_INT or typeof(item) == TYPE_STRING:
			output_queue.append(item)
		elif item in precedence:
			while operator_stack and operator_stack.back() in precedence and precedence[item] <= precedence[operator_stack.back()]:
				output_queue.append(operator_stack.pop_back())
			operator_stack.append(item)

	while operator_stack:
		output_queue.append(operator_stack.pop_back())

	return output_queue

func evaluate_rpn(expression):
	if expression.size() == 0:
		return 0
	var stack = []
	for token in expression:
		if typeof(token) == TYPE_INT:
			stack.append(token)
		elif typeof(token) == TYPE_STRING:
			stack.append(collected_variables[token])
		else:
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
				stack.append(num1 / num2)
			elif token == "/":
				var result = float(num1) / num2
				result = round(result * 10000000000000000) / 10000000000000000
				stack.append(result)
			elif token == "^":
				stack.append(pow(num1, num2))
	return stack[0]

func update_expression():
	var items = []

	for i in range(num_term + oper_term + var_term):
		if i < collected_items.size():
			items.append(str(collected_items[i]))
		else:
			items.append("_")

	var current_expression = ""
	for i in range(items.size()):
		if items[i] == "x" || items[i] || "y":
			if current_expression.ends_with(" "):
				current_expression = current_expression.rstrip(" ")
				current_expression += items[i] + ""
		else:
			current_expression += items[i] + " "
	var result = evaluate_rpn(shunting_yard())
	label.text = current_expression + " = " + str(result)

#func check_final_answer():
#	var current_level = 0.0
#	var current_result = evaluate_rpn(shunting_yard())
#	print("calculation: " + str(evaluate_rpn(shunting_yard())))
#	print("final answer: " + str(final_answer))
#	if str(current_result) == str(final_answer):
#		AudioManager.level_complete_sfx.play()
#		GameSettings.grasscurrentlevel[current_level + 1] = true
#		reset_for_next_level()
#		var time_elapsed = $timer.get_elapsed_time()
#		level_complete_menu.label.text = time_elapsed
#		level_complete_menu.show()
#		get_tree().paused = true
#	elif collected_items.size() == terms && str(current_result) != str(final_answer):
#		AudioManager.play_deathsfx()
#		reset_for_next_level()
#		game_over.show()
#		get_tree().paused = true

func reset_hp():
	health_system._health = 3

func restart():
	reset_hp()
	var current_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)

func reset_for_next_level():
	reset_hp()
	collected_items.clear()
	collected_variables.clear()

func _ready():
	pass

func _process(_delta):
	update_expression()
#	check_final_answer()
