extends Node2D

@onready var collected_numbers := []
@onready var collected_operators := []
@onready var current_expression := ""
@onready var isDestroy = $"bool_handler"
@onready var last_item_was_number = true
#player
@onready var player_pos = $"../slime_player_joystick/slime_player_joystik".position

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
@onready var op2 = $"operator_-/-"
@onready var op3 = $"operator_x/x"
@onready var op4 = $"operator_d/d"

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
	if isDestroy.isDestroy && last_item_was_number:
		collected_numbers.append(num)
		num_counter += 1
		if num_counter == 1:
			current_num = num2
		elif num_counter == 2:
			current_num = num3
		last_item_was_number = false
	update_expression()
	check_final_answer()

func collect_operator(oper):
	if isDestroy.isDestroy && !last_item_was_number:
		collected_operators.append(oper)
		oper_counter += 1
		if oper_counter == 1:
			current_oper = op2
		elif oper_counter == 2:
			pass
		last_item_was_number = true
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

@onready var end_tutorial_1 = $"../typewriter_text_effect/EndTutorial1"
@onready var end_tutorial_2 = $"../typewriter_text_effect/EndTutorial2"
@onready var animation_player = $"../typewriter_text_effect/EndTutorial2/AnimationPlayer"

func check_final_answer():
	var current_result = calculate_expression()
	if current_result == final_answer:
		end_tutorial_1.hide()
		end_tutorial_2.show()
		animation_player.play("typewriter")
		GameSettings.tutorialPlayed = true
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")

	elif collected_numbers.size() == 3 || current_result != calculate_expression():
		AudioManager.play_deathsfx()
		get_tree().change_scene_to_file("res://Scenes/levels/tutorial/tutorial.tscn")

func reset_player_position():
	$"../slime_player_joystick/slime_player_joystik".position = player_pos

func _process(_delta):
	update_expression()
