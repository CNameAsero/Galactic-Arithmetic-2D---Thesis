extends Node2D

var collected_numbers_dict = {}
var number_scene = load("res://Scenes/Mechanics/numbers.tscn")

@onready var collected_numbers := []
@onready var collected_operators := []
@onready var current_expression := ""
@onready var isDestroy = $"bool_handler"
@onready var last_item_was_number = true
#player
@onready var player_pos = $"../slime_player_joystick/slime_player_joystik".position

#final answer
@onready var final_answer = $final_answer.final_answer

#levels
@onready var currentlevel = 0

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

func check_final_answer():
	var current_result = calculate_expression()
	if current_result == final_answer:
		end_tutorial_1.hide()
		AudioManager.tuto7_stop()
		AudioManager.tuto6()
		end_tutorial_2.show()
		GameSettings.tutorialPlayed = true
		await get_tree().create_timer(17).timeout
		AudioManager.tuto6_stop()
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
		AudioManager.level1_music.play()

	elif collected_numbers.size() == 3 || current_result != calculate_expression():
		AudioManager.play_deathsfx()
		get_tree().change_scene_to_file("res://Scenes/levels/tutorial/tutorial.tscn")

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

func reset_player_position():
	$"../slime_player_joystick/slime_player_joystik".position = player_pos

func _process(_delta):
	update_expression()
