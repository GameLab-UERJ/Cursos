# Roteiro de Aula: Dialogue Manager 4 no Godot 4
### *Guia Prático, Divertido e Sem Complicação para Bolsistas e Professores*

> **Laboratório:** GameLab-UERJ  
> **Projeto:** Iniciação à Docência — Ensino de Jogos com Godot  
> **Tema:** Diálogos Interativos com Dialogue Manager 4 & Assets do Kenney  
> **Duração sugerida:** 1h30 a 2h (oficina prática) ou 4 a 5 vídeos curtos (10 min cada)  
> **Filosofia:** *Aprender construindo algo legal, sem complicar à toa!*

---

## 💡 A Ideia da Aula (Visão do Instrutor)

O maior erro ao ensinar ferramentas de diálogo em jogos é começar com teoria abstrata e 20 minutos de slides sobre árvores de nós.

Aqui a gente usa **Project-Based Learning (PBL)** de um jeito leve:
- O aluno começa com um bonequinho na tela que anda.
- Ele anda até o Guarda, aperta **[E]** e... nada acontece ainda.
- Nosso objetivo na aula é fazer esse Guarda **ganhar vida**, conversar, pedir moedas e abrir um portão de verdade.
- Cada etapa resolve um probleminha concreto, dá uma recompensa visual imediata e faz a pessoa pensar: *"Caramba, que daora, isso realmente funciona!"*.

---

## 🧭 As 5 Etapas da Aula (Branches de Apoio)

Se algum aluno se perder ou digitar algo errado no teclado, avise: *"Fica tranquilo, digita `git checkout slice-0X` no terminal que o seu projeto vai direto pro ponto onde a gente está!"*.

```text
slice-00-base-cenario       -> 1. Jogo base: andar com animações Kenney, sons, mapa com colisão e detectar NPC
slice-01-primeiro-dialogo   -> 2. Criar a primeira fala no Dialogue Manager e travar o player
slice-02-escolhas-e-ramificacoes -> 3. Colocar opções de resposta e pausas dramáticas
slice-03-estado-e-condicionais   -> 4. Coletar moedinhas e fazer o diálogo reagir
slice-04-eventos-e-sinais       -> 5. Fazer o diálogo abrir o portão no mapa com 'do' (Projeto Completo)
main                        -> Versão final completa
```

---

## 🎯 Passo a Passo Detalhado para o Instrutor

---

### Etapa 0: A Base do Jogo (10 minutos)
**Branch:** `slice-00-base-cenario`

#### O que falar para a turma:
> *"Galera, abram o projeto. Nosso jogo base já está visualmente vivo e sonoro: temos um cavaleiro com animações de andar e esperar (idle/walk do Kenney), um guardião em vigília, moedas girando com som retrô, paredes de pedra sólida e câmera travada nos limites do mapa. Quando andamos até o Guarda e apertamos [E], aparece o prompt e sai apenas um texto no console. Nosso objetivo na aula é fazer ele falar de verdade usando o Dialogue Manager 4!"*

#### O que mostrar na tela:
1. O personagem e o guarda já utilizam nós `AnimatedSprite2D` com sprites clássicos da Kenney:
   - Player com animação `idle` e `walk` ritmada.
   - Guarda com animação `idle` suave a 1.5 FPS.
   - Moedas giratórias com som de coleta (`coin.ogg`).
2. Mostre como a `Area2D` em volta do Guarda detecta o jogador quando ele entra no círculo:
   ```gdscript
   func _on_area_interacao_body_entered(body: Node2D) -> void:
	   if body is Player:
		   player_por_perto = true
		   prompt_interacao.visible = true
   ```
3. Mostre que o plugin **Dialogue Manager** já está ativado em *Project Settings* e o balão padrão limpo (`cenas/balao/balao.tscn`) já está configurado em *Project Settings > Dialogue Manager > Runtime > Balloon Path*.

---

### Etapa 1: A Primeira Fala e a "Pausa" do Boneco (15 minutos)
**Branch:** `slice-01-primeiro-dialogo`

#### O que falar para a turma:
> *"Em vez de escrever os diálogos dentro do código do jogo, a gente usa um arquivo de texto `.dialogue`. É como um roteiro de cinema: qualquer um da equipe consegue escrever sem precisar ser programador."*

#### Mão na massa:
1. Crie o arquivo `dialogos/guardiao.dialogue`:
   ```dialogue
   ~ inicio

   Guardião: Alto lá, nobre cavaleiro!
   Guardião: O portão à frente está trancado.
   Cavaleiro: Olá! Como posso passar por ele?
   Guardião: Apenas provando seu valor nas ruínas.

   => END
   ```
2. No script do Guarda (`npc_guardiao.gd`), chame o balão:
   ```gdscript
   const DIALOGO_GUARDIAO: DialogueResource = preload("res://dialogos/guardiao.dialogue")

   func interagir() -> void:
	   DialogueManager.show_dialogue_balloon(DIALOGO_GUARDIAO, "inicio")
   ```
3. **O pulo do gato didático:** Pergunte para a turma: *"O que acontece se a gente andar enquanto o balão tá aberto?"*  
   Mostre o boneco andando no fundo enquanto lê. Depois mostre como consertar conectando dois sinais no `player.gd`:
   ```gdscript
   DialogueManager.dialogue_started.connect(func(_res): can_move = false)
   DialogueManager.dialogue_ended.connect(func(_res): can_move = true)
   ```

---

### Etapa 2: Escolhas e Ritmo Narrativo (15 minutos)
**Branch:** `slice-02-escolhas-e-ramificacoes`

#### O que falar para a turma:
> *"Um diálogo só é jogo quando o jogador pode tomar decisões. Vamos dar duas opções para o cavaleiro: aceitar a missão ou recusar."*

#### Mão na massa:
1. No arquivo `.dialogue`, use o hífen `-` para criar escolhas:
   ```dialogue
   - Sim, vou te ajudar!
	   Guardião: [wait=0.3]Sabia que podia contar com você!
	   Guardião: Reúna 3 moedas de ouro para quebrar o selo.
   - Não estou interessado.
	   Guardião: [wait=0.2]Que pena... então o portão continuará fechado.
   ```
2. Explique a tag `[wait=0.3]`: é uma pausa que dá vida e ritmo à fala, parecendo uma respiração humana antes de responder.
3. Mostre o uso de cores com BBCode: `[color=yellow]3 moedas[/color]`.

---

### Etapa 3: Conectando com o Jogo (Moedas e Condicionais) (20 minutos)
**Branch:** `slice-03-estado-e-condicionais`

#### O que falar para a turma:
> *"Se o Guarda pediu 3 moedas, ele tem que saber se a gente tem essas moedas no bolso. Como o diálogo conversa com o inventário do jogo?"*

#### Mão na massa:
1. Apresente o script `scripts/game_state.gd` (um Autoload chamado `GameState`):
   ```gdscript
   var moedas: int = 0
   var missao_aceita: bool = false
   var portao_aberto: bool = false
   ```
2. Mostre as moedinhas espalhadas pelo chão (`moeda.tscn`). Ao encostar numa moeda, ela toca um som (`coin.ogg`), soma `GameState.moedas += 1` e some da tela.
3. No `.dialogue`, use `if` para mudar a fala do Guarda:
   ```dialogue
   if GameState.moedas >= 3:
	   Guardião: Incrível! Você trouxe as 3 moedas!
	   set GameState.moedas -= 3
	   set GameState.portao_aberto = true
	   => END

   if GameState.missao_aceita:
	   Guardião: Você ainda tem apenas {{GameState.moedas}} de 3 moedas. Continue procurando!
	   => END
   ```
4. Destaque como o `{{GameState.moedas}}` imprime o valor exato da variável no meio do texto!

---

### Etapa 4: Fazendo o Diálogo Abrir o Portão (`do`) (15 minutos)
**Branch:** `slice-04-eventos-e-sinais` *(Versão Completa)*

#### O que falar para a turma:
> *"O Guarda falou que o portão abriu... mas ele continua lá na tela bloqueando o caminho! Como o texto do diálogo manda o nó do portão abrir de verdade?"*

#### Mão na massa:
1. No script do Guarda, crie a função de abrir o portão:
   ```gdscript
   func abrir_portao() -> void:
	   if portao:
		   portao.abrir() # troca a sprite para porta aberta, toca som de destravar e desliga a colisão!
   ```
2. Passe o `[self]` como estado extra na chamada do diálogo:
   ```gdscript
   DialogueManager.show_dialogue_balloon(DIALOGO_GUARDIAO, "inicio", [self])
   ```
3. No `.dialogue`, no momento em que ele entrega as moedas, coloque:
   ```dialogue
   do abrir_portao()
   Guardião: O portão está aberto! Siga em frente, herói!
   ```
4. Teste com a turma: colete as 3 moedas ouvindo o som retrô, fale com o guarda, faça suas escolhas, veja o portão abrir com animação/som e atravesse para o outro lado! Ciclo completo do jogo concluído!

---

## 🌟 Desafios Curtos para Fixação (Para os Alunos Fazerem)

Dê 10 minutos para os alunos mexerem e inventarem suas próprias coisas:
1. **Fácil:** Mudar a cor de uma palavra no diálogo usando `[color=lightblue]...[/color]`.
2. **Médio:** Fazer o Guarda pedir 4 moedas em vez de 3 e colocar mais uma moeda escondida no mapa.
3. **Criativo:** Adicionar um cachorrinho ou gatinho perto do portão que fala *"Au au!"* quando você aperta `E`.

---

## 💬 Dica de Ouro para o Bolsista de Docência

- **Não assuma o teclado do aluno:** Se alguém errar, pergunte: *"O que o console vermelho do Godot está dizendo?"*. Quase sempre é uma letra maiúscula/minúscula errada ou uma indentação de Tab.
- **Deixe a turma brincar com o texto:** Deixar os alunos inventarem piadas ou falas engraçadas para o Guarda é o melhor jeito de fixar a sintaxe do `.dialogue`.
- **Elogie o progresso:** Quando o portão abrir pela primeira vez no computador deles, celebre! É o momento onde eles sentem que realmente criaram um jogo.
