extends Node2D

var precedence = {"+": 1, "-": 1, "×": 2, "÷": 2,"^": 3}
var preset_collectibles = {"x": 0, "y": 0}


var collected_items := []
var collected_numbers := []
var collected_variables := []
var collected_operators := []

var isDestroy = false
var last_item_was_number = false
var last_item_was_variable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_algebra()


func collect_numbers(num):
	if isDestroy && !last_item_was_number:
		collected_items.append(num)
		collected_numbers.append(num)
		last_item_was_number = true

func collect_operator(oper):
	if isDestroy && last_item_was_number:
		collected_items.append(oper)
		last_item_was_number = false
		last_item_was_variable = false

func collect_variable(varia):
	if isDestroy and last_item_was_number:
		collected_items.append(varia)
		collected_variables.append(varia)
		last_item_was_number = true

func calculate_algebra():
	var stack = []
	var newstack = []
	if stack.size() < 0:
		return 0
	for i in collected_items:
		if typeof(i) == TYPE_INT:
			stack.append(collected_items[i])
		elif i in preset_collectibles:
			if stack.front():
				stack[i] += collected_variables[i]
			else:
				stack.append(collected_variables[i])
		elif i in collected_operators:
			if stack.size() < 2:
				return 0
			var num2 = stack[1]
			var num1 = stack[0]
			if i == "+":
				stack.append(num1 + num2)
	return stack[0]
