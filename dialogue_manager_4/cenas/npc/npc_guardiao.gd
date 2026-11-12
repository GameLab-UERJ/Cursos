extends CharacterBody2D
class_name NPCGuardiao

## NPC que atua como guardião do portão.
## Utiliza animação de idle do Kenney e aciona o balão padrão do Dialogue Manager 4.

const DIALOGO_GUARDIAO: DialogueResource = preload("res://dialogos/guardiao.dialogue")

@export var portao: Portao

@onready var prompt_interacao: Label = $PromptInteracao
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_por_perto: bool = false
var dialogo_ativo: bool = false

func _ready() -> void:
	prompt_interacao.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	animated_sprite.play("idle")

func _unhandled_input(event: InputEvent) -> void:
	if player_por_perto and not dialogo_ativo and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		interagir()

func interagir() -> void:
	DialogueManager.show_dialogue_balloon(DIALOGO_GUARDIAO, "inicio", [self])

## Método invocado pelo script de diálogo: 'do abrir_portao()'
func abrir_portao() -> void:
	if portao:
		portao.abrir()
	else:
		push_warning("[NPC Guardião]: Nó Portão não configurado!")

func _on_dialogue_started(_res: DialogueResource) -> void:
	dialogo_ativo = true
	prompt_interacao.visible = false

func _on_dialogue_ended(_res: DialogueResource) -> void:
	dialogo_ativo = false
	if player_por_perto:
		prompt_interacao.visible = true

func _on_area_interacao_body_entered(body: Node2D) -> void:
	if body is Player:
		player_por_perto = true
		if not dialogo_ativo:
			prompt_interacao.visible = true

func _on_area_interacao_body_exited(body: Node2D) -> void:
	if body is Player:
		player_por_perto = false
		prompt_interacao.visible = false
