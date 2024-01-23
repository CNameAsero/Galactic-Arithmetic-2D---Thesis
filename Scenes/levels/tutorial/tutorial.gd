extends Node2D
@onready var isTrigger = false
@onready var buttonpress = 0

@onready var sample_text = $typewriter_text_effect/sample_text
@onready var animation_player = $typewriter_text_effect/sample_text/AnimationPlayer

@onready var step_1 = $"typewriter_text_effect/Step 1"
@onready var animation_player1 = $"typewriter_text_effect/Step 1/AnimationPlayer"

@onready var number_collect = $typewriter_text_effect/Number_Collect
@onready var animation_player2 = $typewriter_text_effect/Number_Collect/AnimationPlayer

@onready var step_2 = $"typewriter_text_effect/Step 2"
@onready var animation_player3 = $"typewriter_text_effect/Step 2/AnimationPlayer"

@onready var press_operator = $typewriter_text_effect/Press_Operator
@onready var animation_player4 = $typewriter_text_effect/Press_Operator/AnimationPlayer


@onready var end_tutorial_1 = $typewriter_text_effect/EndTutorial1
@onready var animation_player5 = $typewriter_text_effect/EndTutorial1/AnimationPlayer

@onready var end_tutorial_2 = $typewriter_text_effect/EndTutorial2
@onready var animation_player6 = $typewriter_text_effect/EndTutorial2/AnimationPlayer

func _ready():
	sample_text.show()
	animation_player.play("typewriter")

func _on_button_pressed():
	$"typewriter_text_effect/sample_text/Button".disabled = true
	buttonpress += 1
	if buttonpress == 1:
		await get_tree().create_timer(3).timeout
		sample_text.hide()
		await get_tree().create_timer(1).timeout
		step_1.show()
		animation_player1.play("typewriter")

func _on_button_1_pressed():
	$"typewriter_text_effect/Step 1/Button1".disabled = true
	buttonpress += 1
	if buttonpress ==2:
		await get_tree().create_timer(3).timeout
		step_1.hide()
		await get_tree().create_timer(0.5).timeout
		number_collect.show()
		animation_player2.play("typewriter")

func _on__body_entered(body):
	if body:
		number_collect.hide()
		await get_tree().create_timer(0.5).timeout
		step_2.show()
		animation_player3.play("typewriter")
		await get_tree().create_timer(7).timeout
		step_2.hide()
		press_operator.show()
		animation_player4.play("typewriter")

func _on__plusbody_entered(body):
	if body:
		if isTrigger:
			pass
		else:
			press_operator.hide()
			await get_tree().create_timer(2).timeout
			end_tutorial_1.show()
			animation_player5.play("typewriter")
			isTrigger = true
	

