extends StaticBody3D

class_name Interactable

signal interacted()

@export var prompt_message = "Interactable"
@export var prompt_action = "interact"
@export var key_name = 'E'

func get_prompt():
	return prompt_message + "\n" +"[" + key_name + "]"
	
func interact(body):
	emit_signal("interacted")
