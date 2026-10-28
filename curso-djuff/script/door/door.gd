extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Garante que a porta começa fechada e com colisão
	anim.play("close")
	collision.set_deferred("disabled", false)

# Função que será chamada quando a chave for pega
func _on_key_collected() -> void:
	# Desativa a colisão para o jogador passar
	collision.set_deferred("disabled", true)
	
	# Toca a animação de abrir
	anim.play("open")
