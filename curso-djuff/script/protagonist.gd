extends CharacterBody2D
class_name Protagonist

const SPEED = 100.0
const ACCELERATION = 1500.0
const FRICTION = 2000.0

@onready var camera: Camera2D = $Camera2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity.length())
	move_and_slide()
	global_position = global_position.round()
	#camera
