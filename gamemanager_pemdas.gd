extends Node2D

var last_item_was_number = false
var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2, "^": 3, "(": 0}


@onready var collected_numbers := []
@onready var collected_operators := []
@onready var collected_parentheses := []
@onready var collected_items := []
@onready var isDestroy = false
@onready var open = false
@onready var expression_label = $CurrentExpressionLabel

@export_category("how many terms?")
@export var num_term : int
@onready var oper_term = num_term - 1

func collect_number(num):
	if isDestroy && !last_item_was_number:
		collected_numbers.append(num)
		collected_items.append(num)
		last_item_was_number = true
	update_expression()

func collect_operator(oper):
	if isDestroy && last_item_was_number:
		collected_operators.append(oper)
		collected_items.append(oper)
		last_item_was_number = false
	update_expression()

func collect_open_parenthesis(paren):
	if isDestroy && !last_item_was_number:
		collected_items.append("(")
		collected_parentheses.append(paren)
		last_item_was_number = false
		open = true
	update_expression()

func collect_close_parenthesis(paren):
	if isDestroy && last_item_was_number:
		collected_items.append(")")
		collected_parentheses.append(paren)
		last_item_was_number = true
	update_expression()

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
				print("Not enough numbers for operator")
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
	
	for i in range(collected_items.size()):
		items.append(str(collected_items[i]))

	var current_expression = ""
	for i in range(collected_items.size()):
		current_expression += items[i] + " "

	$CurrentExpressionLabel.text = current_expression + " = " + str(evaluate_rpn(shunting_yard()))

func _ready():
	pass

func _process(_delta):
	update_expression()
