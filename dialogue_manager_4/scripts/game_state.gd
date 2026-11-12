extends Node

## Autoload global para gerenciar o estado da missão e dados do jogo.
## O Dialogue Manager consegue ler e modificar diretamente as variáveis
## deste nó utilizando as diretivas 'if' e 'set'.

signal moedas_alteradas(nova_quantidade: int)
signal missao_atualizada(estado: bool)

var moedas: int = 0:
	set(valor):
		moedas = max(0, valor)
		moedas_alteradas.emit(moedas)

var missao_aceita: bool = false:
	set(valor):
		missao_aceita = valor
		missao_atualizada.emit(missao_aceita)

var portao_aberto: bool = false

func reset() -> void:
	moedas = 0
	missao_aceita = false
	portao_aberto = false

func adicionar_moeda(quantidade: int = 1) -> void:
	moedas += quantidade
