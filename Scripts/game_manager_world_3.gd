extends Node2D

@onready var collected_numbers := []
@onready var collected_operators := []
@onready var current_expression := ""
@onready var isDestroy = $bool_handler
@onready var last_item_was_number = true

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1

@onready var time_elapsed = ""
@onready var game_over = $"../menus/game_over"
@onready var level_complete_menu = $"../menus/level_complete_menu"
@onready var player_pos = $"../slime_player_joystick/slime_player_joystik".position
@onready var final_answer = $final_answer.final_answer

@onready var currentlevel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_expression()

func pemdas_expression():
	if collected_numbers.size() == 0: #if array no value then return 0
		return 0

	var numbers_stack = []
	var operators_stack = []

	for i in range(collected_numbers.size()):
		var number = collected_numbers[i]
		numbers_stack.append(number)

		if i < collected_operators.size():
			var oper = collected_operators[i]

			while operators_stack.size() > 0 and precedence(oper) <= precedence(operators_stack[-1]):
				if numbers_stack.size() < 2:
					return 0
				var num2 = numbers_stack.pop_back()
				var num1 = numbers_stack.pop_back()
				var op = operators_stack.pop_back()
				numbers_stack.append(apply_operator(op, num1, num2))

			operators_stack.append(oper)

	while operators_stack.size() > 0:
		if numbers_stack.size() < 2:
			return 0
		var num2 = numbers_stack.pop_back()
		var num1 = numbers_stack.pop_back()
		var op = operators_stack.pop_back()
		numbers_stack.append(apply_operator(op, num1, num2))

	return numbers_stack[0]
func precedence(oper):
	match oper:
		"+", "-":
			return 1
		"×", "÷":
			return 2
		_:
			return 0

func apply_operator(oper, num1, num2):
	match oper:
		"+":
			return num1 + num2
		"-":
			return num1 - num2
		"×":
			return num1 * num2
		"÷":
			if num2 != 0:
				return num1 / num2
			else:
				print("Division by zero error")
				return 0

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

	current_expression = "(" + numbers[0]
	for i in range(1, num_term):
		if i <= collected_operators.size() and operators[i-1] != "_":
			current_expression += " " + operators[i-1] + " " + numbers[i]
		elif i < collected_numbers.size():
			current_expression += " _ " + numbers[i]
		else:
			current_expression += " _ _"
		if i == 1:
			current_expression += ")"

	get_child(1).text = current_expression + " = " + str(pemdas_expression())

func check_final_answer_pemdas():
	var current_result = pemdas_expression()
	if current_result == final_answer:
		AudioManager.level_complete_sfx.play()
		GameSettings.grasscurrentlevel[currentlevel + 1] = true
		reset_for_next_level()
		time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		get_tree().paused = true
	elif collected_numbers.size() == num_term || current_result != pemdas_expression():
		AudioManager.play_deathsfx()
		reset_for_next_level()
		game_over.show()
		get_tree().paused = true

func collect_number(num):
	if isDestroy.isDestroy && last_item_was_number:
		collected_numbers.append(num)
		last_item_was_number = false
	update_expression()
	check_final_answer_pemdas()

func collect_operator(oper):
	if isDestroy.isDestroy && !last_item_was_number:
		collected_operators.append(oper)
		last_item_was_number = true
	update_expression()
	check_final_answer_pemdas()

func reset_player_position():
	$"../Slime_player".position = player_pos

func restart():
	reset_hp()
	var current_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)

func reset_for_next_level():
	reset_hp()
	collected_numbers.clear()
	collected_operators.clear()

func _on_timer_timeout():
	AudioManager.play_deathsfx()
	game_over.show()
	get_tree().paused = true
	reset_for_next_level()

func reset_hp():
	pass
	#health_system._health = 3
