extends CharacterBody2D
class_name Player

## Controla a movimentação do jogador em 2D top-down com animações de idle e walk do Kenney.

@export var speed: float = 140.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool = true

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	animated_sprite.play("idle")

func _physics_process(_delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		animated_sprite.play("idle")
		move_and_slide()
		return
	
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if velocity.length() > 0:
		animated_sprite.play("walk")
		if input_direction.x > 0:
			animated_sprite.flip_h = true
		elif input_direction.x < 0:
			animated_sprite.flip_h = false
	else:
		animated_sprite.play("idle")
	
	move_and_slide()

func _on_dialogue_started(_resource: DialogueResource) -> void:
	can_move = false
	animated_sprite.play("idle")

func _on_dialogue_ended(_resource: DialogueResource) -> void:
	can_move = true
