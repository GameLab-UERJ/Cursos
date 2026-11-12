extends Area2D
class_name MoedaItem

## Item coletável pelo jogador no mapa.
## Incrementa a contagem de moedas no GameState e toca efeito sonoro do Kenney.

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

var coletado: bool = false

func _ready() -> void:
	animated_sprite.play("spin")
	# Animação suave de flutuação vertical usando Tween
	var tween := create_tween().set_loops()
	tween.tween_property(animated_sprite, "position:y", -3.0, 0.6).set_trans(Tween.TRANS_SINE)
	tween.tween_property(animated_sprite, "position:y", 3.0, 0.6).set_trans(Tween.TRANS_SINE)

func _on_body_entered(body: Node2D) -> void:
	if coletado:
		return
	if body is Player:
		coletado = true
		GameState.adicionar_moeda(1)
		audio_stream.play()
		animated_sprite.visible = false
		set_deferred("monitoring", false)
		await audio_stream.finished
		queue_free()
