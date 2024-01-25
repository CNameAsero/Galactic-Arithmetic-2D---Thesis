extends Node2D

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

#numbers
#@onready var num0 = $"Numbers/set_number"
@onready var num1 = $"Number_5/5"
@onready var num2 = $"Number_4/4"
@onready var num3 = $"Number_1/1"
@onready var num4 = $"Number_6/6"
@onready var num5 = $"Number_9/9"
#@onready var num6 = $"Numbers/set_number"
#@onready var num7 = $"Numbers/set_number"
#@onready var num8 = $"Numbers/set_number"
#@onready var num9 = $"Numbers/set_number"

#operators
@onready var op1 = $"operator_+/+"
#@onready var op2 = $"operator_-/-"
#@onready var op3 = $"operator_x/x"
#@onready var op4 = $"operator_d/d"

#counters
@onready var current_num = num1
@onready var current_oper = op1
@onready var num_counter = 0
@onready var oper_counter = 0

#levels
@onready var currentlevel = 0

func _ready():
	pass

func collect_number(num):
	# Only collect the number if the last item was not a number
	if isDestroy.isDestroy && last_item_was_number:
		collected_numbers.append(num)
		num_counter += 1
		if num_counter == 1:
			current_num = num2
		elif num_counter == 2:
			current_num = num3
		last_item_was_number = false  # Update the flag
	update_expression()
	check_final_answer()

func collect_operator(oper):
	# Only collect the operator if the last item was a number
	if isDestroy.isDestroy && !last_item_was_number:
		collected_operators.append(oper)
		oper_counter += 1
		#if oper_counter == 1:
			#current_oper = op2
		#elif oper_counter == 2:
			#pass
		last_item_was_number = true  # Update the flag
	update_expression()
	check_final_answer()

func update_expression():
	var numbers = ["_", "_", "_"]
	var operators = ["_", "_"]

	for i in range(min(collected_numbers.size(), 3)):
		numbers[i] = str(collected_numbers[i])

	for i in range(min(collected_operators.size(), 2)):
		operators[i] = str(collected_operators[i])

	current_expression = numbers[0]
	if operators[0] != "_":
		current_expression += " " + operators[0] + " " + numbers[1]
	else:
		current_expression += " _ _"
	if operators[1] != "_":
		current_expression += " " + operators[1] + " " + numbers[2]
	else:
		current_expression += " _ _"

	$CurrentExpressionLabel.text = current_expression + " = " + str(calculate_expression())

#func update_expression():
#	var numbers = ["_", "_", "_"]
#	var operators = ["_", "_"]
#
#	for i in range(collected_numbers.size()):
#		numbers[i] = str(collected_numbers[i])
#
#	for i in range(collected_operators.size()):
#		operators[i] = str(collected_operators[i])
#
#	current_expression = numbers[0] + " " + operators[0] + " " + numbers[1] + " " + operators[1] + " " + numbers[2]
#
#	$CurrentExpressionLabel.text = current_expression + " = " + str(calculate_expression())

#func update_expression():
#	current_expression = " "
#	for i in range (collected_numbers.size()):
#		if i < collected_operators.size():
#			current_expression += " " + str(collected_numbers[i])
#			current_expression += " " + str(collected_operators[i])
#		else:
#			current_expression += str(collected_numbers[i])
#	$CurrentExpressionLabel.text = current_expression + " = " + str(calculate_expression())

func calculate_expression():
	if collected_numbers.size() == 0: #if array no value then return 0
		return 0

	var result = collected_numbers[0]
	for i in range(1, collected_numbers.size()):
		var number = collected_numbers[i]
		var oper = null
		if i - 1 < collected_operators.size():
			oper = collected_operators[i - 1] # Operator preceding the current number
		else:
			print("Operator index out of bounds: ", i)
			continue
		
		match oper:
			"+":
				result += number
			"-":
				result -= number
			"*":
				result *= number
			"/":
				if number != 0:
					result /= number
				else:
					print("Division by zero error")
					return 0
	return result

func check_final_answer():
	var current_result = calculate_expression()
	if current_result == final_answer:
		AudioManager.level_complete_sfx.play()
		GameSettings.grasscurrentlevel[currentlevel + 1] = true
		reset_for_next_level()
		time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
		get_tree().paused = true
	elif collected_numbers.size() == 3 || current_result != calculate_expression():
		AudioManager.play_deathsfx()
		reset_for_next_level()
		game_over.show()
		get_tree().paused = true

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
	num_counter = 0
	oper_counter = 0
	current_num = num1
	current_oper = op1

func _on_timer_timeout():
	AudioManager.play_deathsfx()
	game_over.show()
	get_tree().paused = true
	reset_for_next_level()

func reset_hp():
	health_system._health = 3

func _process(_delta):
	update_expression()
