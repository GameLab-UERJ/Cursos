extends Node2D

## Cena principal do tutorial.
## Gerencia o ambiente, os limites do mapa e o HUD simples de moedas.

@onready var label_hud: Label = $HUD/LabelHUD

func _ready() -> void:
	GameState.moedas_alteradas.connect(_on_moedas_alteradas)
	atualizar_hud()

func atualizar_hud() -> void:
	if label_hud:
		if GameState.portao_aberto:
			label_hud.text = "Portão aberto! Siga em frente."
		elif GameState.moedas >= 3:
			label_hud.text = "Moedas: 3/3 (Fale com o Guardião)"
		elif GameState.missao_aceita:
			label_hud.text = "Moedas: %d/3" % GameState.moedas
		else:
			label_hud.text = "Fale com o Guardião [E]"

func _on_moedas_alteradas(_nova_qtd: int) -> void:
	atualizar_hud()
