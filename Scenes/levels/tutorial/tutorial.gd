extends Node2D
@onready var isTrigger = false
@onready var buttonpress = 0

@onready var sample_text = $typewriter_text_effect/sample_text


@onready var step_1 = $"typewriter_text_effect/Step 1"


@onready var number_collect = $typewriter_text_effect/Number_Collect


@onready var step_2 = $"typewriter_text_effect/Step 2"


@onready var press_operator = $typewriter_text_effect/Press_Operator



@onready var end_tutorial_1 = $typewriter_text_effect/EndTutorial1


@onready var end_tutorial_2 = $typewriter_text_effect/EndTutorial2


func _ready():
	AudioManager.tuto1()
	sample_text.show()

func _on_button_pressed():
	$"typewriter_text_effect/sample_text/Button".disabled = true
	buttonpress += 1
	if buttonpress == 1:
		await get_tree().create_timer(3).timeout
		AudioManager.tuto1_stop()
		sample_text.hide()
		await get_tree().create_timer(1).timeout
		AudioManager.tuto2()
		step_1.show()

func _on_button_1_pressed():
	$"typewriter_text_effect/Step 1/Button1".disabled = true
	buttonpress += 1
	if buttonpress ==2:
		await get_tree().create_timer(3).timeout
		AudioManager.tuto2_stop()
		step_1.hide()
		await get_tree().create_timer(0.5).timeout
		AudioManager.tuto3()
		number_collect.show()

func _on_set_number_body_entered(body):
	if body:
		number_collect.hide()
		AudioManager.tuto3_stop()
		await get_tree().create_timer(0.5).timeout
		step_2.show()
		AudioManager.tuto4()

func _on__plusbody_entered(body):
	if body:
		if isTrigger:
			pass
		else:
			AudioManager.tuto5_stop()
			press_operator.hide()
			await get_tree().create_timer(2).timeout
			AudioManager.tuto7()
			end_tutorial_1.show()
			isTrigger = true

func _on_button_3_pressed():
	$"typewriter_text_effect/Step 2/Button3".disabled = true
	buttonpress += 1
	if buttonpress ==3:
		await get_tree().create_timer(3).timeout
		AudioManager.tuto4_stop()
		step_2.hide()
		await get_tree().create_timer(1).timeout
		AudioManager.tuto5()
		press_operator.show()
