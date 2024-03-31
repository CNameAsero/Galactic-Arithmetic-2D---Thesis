extends Node2D

var collected_numbers_dict = {}
var number_scene = load("res://Scenes/Mechanics/numbers_w4.tscn")

var last_item_was_number = false
var can_collect_fraction = true
var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2, "/": 3,"^": 4, "(": 0}

@onready var collected_parentheses := []
@onready var collected_items := []
@onready var isDestroy = false
@onready var open = false
@onready var label = $"1st_label"

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1
@onready var terms = num_term + oper_term
@onready var health_system = $"../slime_player_joystick/Camera2D/CanvasLayer/health_system"

@onready var final_answer = $final_answer_w4.final_answer
@onready var level_complete_menu = $"../CanvasLayer/menus/level_complete_menu"
@onready var game_over = $"../CanvasLayer/menus/game_over"

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

func collect_open_parenthesis():
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
			operator_stack.pop_back()
		elif item in precedence:
			while operator_stack and operator_stack.back() in precedence and precedence[item] <= precedence[operator_stack.back()]:
				output_queue.append(operator_stack.pop_back())
			operator_stack.append(item)

	while operator_stack:
		output_queue.append(operator_stack.pop_back())

	return output_queue

func gcd(a, b):
	while b != 0:
		var temp = a
		a = b
		b = temp % b
	return a

func decimal_to_nearest_fraction(decimal, limit=36):
	var best_numerator = 0
	var best_denominator = 1
	var best_difference = abs(decimal)

	for denominator in range(1, limit + 1):
		var numerator = round(decimal * denominator)
		var difference = abs(decimal - float(numerator) / denominator)
		if difference < best_difference:
			best_difference = difference
			best_numerator = numerator
			best_denominator = denominator

	var divisor = gcd(int(best_numerator), int(best_denominator))
	best_numerator /= divisor
	best_denominator /= divisor
	if best_denominator < 0:
		best_numerator *= -1
		best_denominator *= -1

	return str(int(best_numerator)) + "/" + str(int(best_denominator))


	return str(int(best_numerator)) + "/" + str(int(best_denominator))

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
			elif token == "/":
				var result = float(num1) / num2
				result = round(result * 10000000000000000) / 10000000000000000
				stack.append(result)
			elif token == "^":
				stack.append(pow(num1, num2))
	return stack[0]

func update_expression():
	var items = []

	for i in range(num_term + oper_term):
		if i < collected_items.size():
			items.append(str(collected_items[i]))
		else:
			items.append("_")

	var current_expression = ""
	for i in range(items.size()):
		if items[i] == "/":
			if current_expression.ends_with(" "):
				current_expression = current_expression.rstrip(" ")
				current_expression += items[i] + ""
		else:
			current_expression += items[i] + " "
	var result = evaluate_rpn(shunting_yard())
	if typeof(result) == TYPE_FLOAT:
		result = decimal_to_nearest_fraction(result)
	label.text = current_expression + " = " + str(result)

func check_final_answer():
	var current_level = 0.0
	var current_result = evaluate_rpn(shunting_yard())
	if str(current_result) == str(final_answer):
		AudioManager.level_complete_sfx.play()
		if GameSettings.current_level % 5 == 0 && !GameSettings.cutscene4 && !GameSettings.world_completed.get(GameSettings.current_level, false) && GameSettings.current_level == 20:
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.currentlevel[GameSettings.current_level - 1] and GameSettings.max_unlocked_level < GameSettings.current_level:
			GameSettings.max_unlocked_level += 1
			GameSettings.currentlevel[GameSettings.current_level] = true
		reset_for_next_level()
		var time_elapsed = $CanvasLayer/timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		GameSettings.player_invulnerable = false
		GameSettings._autosave()
		get_tree().paused = true
	elif collected_items.size() == terms && str(current_result) != str(final_answer):
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
	
	if GameSettings.current_level == 16:
		scenes = ["res://Scenes/levels/level_16.tscn", "res://Scenes/levels/level_16_1.tscn", "res://Scenes/levels/level_16_2.tscn"]
	elif GameSettings.current_level == 17:
		scenes = ["res://Scenes/levels/level_17.tscn", "res://Scenes/levels/level_17_1.tscn", "res://Scenes/levels/level_17_2.tscn"]
	elif GameSettings.current_level == 18:
		scenes = ["res://Scenes/levels/level_18.tscn", "res://Scenes/levels/level_18_1.tscn", "res://Scenes/levels/level_18_2.tscn"]
	elif GameSettings.current_level == 19:
		scenes = ["res://Scenes/levels/level_19.tscn", "res://Scenes/levels/level_19_1.tscn", "res://Scenes/levels/level_19_2.tscn"]
	elif GameSettings.current_level == 20:
		scenes = ["res://Scenes/levels/level_20.tscn", "res://Scenes/levels/level_20_1.tscn", "res://Scenes/levels/level_20_2.tscn"]

	var random_index = rng.randi_range(0, scenes.size() - 1)
	var random_scene = scenes[random_index]
	get_tree().change_scene_to_file(random_scene)

func save_collectible_number(collectible):
	var collectible_number = {
		"value": collectible.number,
		"position": collectible.global_position,
		"color": collectible.modulate
	}
	collected_numbers_dict[collectible] = collectible_number

func clear_eq():
	collected_items.clear()
	collected_parentheses.clear()
	last_item_was_number = false
	can_collect_fraction = true

	for collectible_name in collected_numbers_dict:
		var collectible_info = collected_numbers_dict[collectible_name]
		var new_collectible = number_scene.instantiate()
		new_collectible.number = collectible_info["value"]
		new_collectible.global_position = collectible_info["position"]
		new_collectible.modulate = collectible_info["color"]
		add_child(new_collectible)
	collected_numbers_dict.clear()

func reset_for_next_level():
	GameSettings.player_invulnerable = false
	reset_hp()
	collected_items.clear()
	collected_parentheses.clear()

func _ready():
	GameSettings.isHard = true

func _process(_delta):
	update_expression()
	check_final_answer()
