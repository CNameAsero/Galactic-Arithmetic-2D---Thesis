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
#levels
@onready var currentlevel = 0

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1

func _ready():
	GameSettings._autoload()

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
					result /= number
				else:
					print("Division by zero error")
					return 0
	return result

func check_final_answer():
	var current_result = calculate_expression()
	if current_result == final_answer:
		AudioManager.level_complete_sfx.play()
		reset_for_next_level()
		if GameSettings.current_level % 5 == 0 && !GameSettings.cutscene1 && !GameSettings.world_completed.get(GameSettings.current_level, false):
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.current_level % 5 == 0 && !GameSettings.cutscene2 && !GameSettings.world_completed.get(GameSettings.current_level, false):
				GameSettings.current_world += 1
				GameSettings.world_completed[GameSettings.current_level] = true
		if GameSettings.currentlevel[GameSettings.current_level - 1] and GameSettings.max_unlocked_level < GameSettings.current_level:
			GameSettings.max_unlocked_level += 1
			GameSettings.currentlevel[GameSettings.current_level] = true
		time_elapsed = $timer.get_elapsed_time()
		level_complete_menu.label.text = time_elapsed
		level_complete_menu.show()
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
	var current_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)

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
