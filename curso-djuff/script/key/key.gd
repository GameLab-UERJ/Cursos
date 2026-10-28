extends Area2D

# Cria um sinal para avisar que a chave foi pega
signal key_collected

func _on_body_entered(body: Node2D) -> void:
	# Verifica se quem encostou é o Player
	if body.is_in_group("Player"):
		key_collected.emit() # Avisa que a chave foi pega
		
		# Opcional: tocar som de pegar item aqui
		# $AudioStreamPlayer2D.play()
		
		queue_free() # Destrói a chave da cena
