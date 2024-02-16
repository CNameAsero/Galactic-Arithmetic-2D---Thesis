extends Node2D

var last_item_was_number = false
var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2, "^": 3, "(": 0}

@onready var collected_parentheses := []
@onready var collected_items := []
@onready var isDestroy = false
@onready var open = false
@onready var expression_label = $CurrentExpressionLabel

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1
var parentheses = 2
@onready var terms = num_term + oper_term + parentheses
@onready var health_system = $"../health_system"

@onready var final_answer = $final_answer.final_answer
@onready var level_complete_menu = $"../menus/level_complete_menu"
@onready var game_over = $"../menus/game_over"

func collect_number(num):
	if isDestroy && !last_item_was_number:
		collected_items.append(num)
		last_item_was_number = true
	update_expression()
	check_final_answer()

func collect_operator(oper):
	if isDestroy && last_item_was_number:
		collected_items.append(oper)
		last_item_was_number = false
	update_expression()
	check_final_answer()

func collect_open_parenthesis(paren):
	if isDestroy && !last_item_was_number:
		collected_items.append("(")
		last_item_was_number = false
		open = true
	update_expression()
	check_final_answer()

func collect_close_parenthesis(paren):
	if isDestroy && last_item_was_number:
		collected_items.append(")")
		collected_parentheses.append(paren)
		last_item_was_number = true
	update_expression()
	check_final_answer()

func shunting_yard():
	var output_queue = []
	var operator_stack = []

	for item in collected_items:
		if typeof(item) == TYPE_INT:
			output_queue.append(item)
		elif item == "(":
			operator_stack.append(item)
		elif item == ")":
			while operator_stack and operator_stack.back() != "(":
				output_queue.append(operator_stack.pop_back())
			operator_stack.pop_back()  # Discard the left parenthesis
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
			elif token == "^":
				stack.append(pow(num1, num2))
	return stack[0]

func update_expression():
	var items = []

	for i in range(num_term + oper_term + parentheses):
		if i < collected_items.size():
			items.append(str(collected_items[i]))
		else:
			items.append("_")

	var current_expression = ""
	for i in range(items.size()):
		current_expression += items[i] + " "

	$CurrentExpressionLabel.text = current_expression + " = " + str(evaluate_rpn(shunting_yard()))

func check_final_answer():
	var current_level = 0
	var current_result = evaluate_rpn(shunting_yard())

	if current_result == final_answer:
		AudioManager.level_complete_sfx.play()
		if GameSettings.current_level % 5 == 0 && !GameSettings.cutscene3 && !GameSettings.world_completed.get(GameSettings.current_level, false) && GameSettings.current_level == 15:
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
	elif collected_items.size() == terms || current_result != evaluate_rpn(shunting_yard()):
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
	
	if GameSettings.current_level == 11:
		scenes = ["res://Scenes/levels/level_11.tscn", "res://Scenes/levels/level_11_1.tscn", "res://Scenes/levels/level_11_2.tscn"]
	elif GameSettings.current_level == 12:
		scenes = ["res://Scenes/levels/level_12.tscn", "res://Scenes/levels/level_12_1.tscn", "res://Scenes/levels/level_12_2.tscn"]
	elif GameSettings.current_level == 13:
		scenes = ["res://Scenes/levels/level_13.tscn", "res://Scenes/levels/level_13_1.tscn", "res://Scenes/levels/level_13_2.tscn"]
	elif GameSettings.current_level == 14:
		scenes = ["res://Scenes/levels/level_14.tscn", "res://Scenes/levels/level_14_1.tscn", "res://Scenes/levels/level_14_2.tscn"]
	elif GameSettings.current_level == 15:
		scenes = ["res://Scenes/levels/level_15.tscn", "res://Scenes/levels/level_15_1.tscn", "res://Scenes/levels/level_15_2.tscn"]

	var random_index = rng.randi_range(0, scenes.size() - 1)
	var random_scene = scenes[random_index]
	get_tree().change_scene_to_file(random_scene)

func reset_for_next_level():
	reset_hp()
	collected_items.clear()
	collected_parentheses.clear()
	GameSettings.player_invulnerable = false

func _ready():
	GameSettings.isHard = true

func _process(_delta):
	update_expression()
