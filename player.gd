extends CharacterBody3D


const SPEED = 10
const JUMP_VELOCITY = 4.5
const look_sensitivity = 0.001


@onready var head : Node3D = $Head
@onready var playerCam : Camera3D = $Head/Camera3D

@onready var raycast : RayCast3D = $Head/RayCast3D


func _process(delta):
	_HandleMovemet(delta)


func _HandleMovemet(delta):
	##UI Inputs
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Movement direction
	var movement_direction = Vector3.ZERO
	if Input.is_key_pressed(KEY_W):
		movement_direction -= global_transform.basis.z 
	if Input.is_key_pressed(KEY_S):
		movement_direction += global_transform.basis.z  
	if Input.is_key_pressed(KEY_A):
		movement_direction -= global_transform.basis.x  
	if Input.is_key_pressed(KEY_D):
		movement_direction += global_transform.basis.x  
	if Input.is_key_pressed(KEY_SPACE):
		movement_direction += global_transform.basis.y  
	if Input.is_key_pressed(KEY_SHIFT):
		movement_direction -= global_transform.basis.y  

	if movement_direction != Vector3.ZERO:
		move_and_collide(movement_direction.normalized() * SPEED * delta) 

	var mouse_delta = Input.get_last_mouse_velocity() * look_sensitivity * delta
	if mouse_delta != Vector2.ZERO:
		var up_direction = Vector3.UP
		global_transform.basis = Basis(up_direction, -mouse_delta.x) * global_transform.basis
		
		var right_direction = global_transform.basis.x.normalized()
		head.global_transform.basis = Basis(right_direction, -mouse_delta.y) * head.global_transform.basis
	
