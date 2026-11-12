extends StaticBody2D
class_name Portao

## Portão ancestral que bloqueia a passagem do jogador.
## Aberto através da instrução 'do abrir_portao()' chamada a partir do diálogo.

signal portao_aberto_sinal

@onready var sprite: Sprite2D = $Sprite2D
@onready var colisao: CollisionShape2D = $CollisionShape2D
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

const TEX_ABERTO: Texture2D = preload("res://assets/sprites/portao_aberto.png")

var esta_aberto: bool = false

func abrir() -> void:
	if esta_aberto:
		return
	esta_aberto = true
	sprite.texture = TEX_ABERTO
	colisao.set_deferred("disabled", true)
	audio_stream.play()
	portao_aberto_sinal.emit()
	print("[Portão]: As correntes ancestrais caíram. O caminho está livre!")
