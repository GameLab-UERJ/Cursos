# Tutorial Prático: Dialogue Manager 4 no Godot 4
> **GameLab UERJ — Projeto de Iniciação à Docência**  
> *"Ensino de Desenvolvimento de Jogos Digitais com Godot: Produção de Minicursos, Vídeo-Aulas e Cursos Online"*  
> **Orientação:** Prof. Gabriel | **Bolsista:** Igor Amaral  
> **Assets:** [Kenney 2D](https://kenney.nl/assets/category:2D) (CC0)

---

## 🎯 Sobre o Projeto

Este projeto foi criado para ser um tutorial **direto, divertido e sem enrolação** para quem quer aprender a usar o [Dialogue Manager 4 (Nathan Hoad)](https://github.com/nathanhoad/godot_dialogue_manager) no **Godot 4**.

A ideia não é complicar nem afundar o aluno em arquiteturas pesadas: utilizando a metodologia **Project-Based Learning (PBL)**, o estudante constrói um mini-jogo RPG 2D simples e charmoso com os clássicos assets do **Kenney**:
1. O jogador controla um cavaleiro em 2D top-down.
2. Anda até o Guarda do portão e aperta `[E]`.
3. Uma conversa gostosa se abre na tela.
4. O Guarda pede 3 moedas para abrir a passagem.
5. O jogador explora, pega as moedas pelo mapa e volta.
6. O diálogo detecta as moedas, o guarda agradece e o portão se abre magicamente com som!

---

## 🧭 As Fatias do Projeto (Branches Git)

Para que o aprendizado seja fluido e você nunca fique travado, o projeto foi dividido em **fatias incrementais (*slices*)**. Se em algum momento você se perder ou seu código der erro, basta trocar de branch com o Git:

| Branch / Fatia | O que você aprende nessa etapa? |
|---|---|
| [`slice-00-base-cenario`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Jogo Base:** Cenário de masmorra Kenney, player e guarda animados (idle/walk), moedas com som, câmera limitada e detecção de proximidade com `Area2D`. |
| [`slice-01-primeiro-dialogo`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Primeira Fala:** Criar o arquivo `.dialogue` e chamar a fala na tela usando `DialogueManager.show_dialogue_balloon()`, pausando o boneco para não andar enquanto fala. |
| [`slice-02-escolhas-e-ramificacoes`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Opções na Tela:** Dar escolhas para o jogador (`- Sim / - Não`) e usar pausas dramáticas com `[wait=0.3]`. |
| [`slice-03-estado-e-condicionais`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Variáveis no Diálogo:** Criar um script global (`GameState`) para guardar moedas e fazer o diálogo mudar dependendo se você já tem as moedas ou não. |
| [`slice-04-eventos-e-sinais`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Ação no Jogo (`do`):** Fazer o próprio diálogo mandar o jogo abrir o portão usando o comando `do abrir_portao()`. |
| [`main`](https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID) | **Projeto Completo:** Versão final com tudo integrado e o roteiro do instrutor. |

---

## 🕹️ Como Rodar no seu Computador

### Pré-requisitos
- **Godot Engine 4.2+** (Funciona perfeito no Godot 4.3, 4.4 e 4.6).
- Git instalado.

### Passo a Passo
```bash
# 1. Clone o repositório
git clone https://github.com/igor-mrs/Tutorial-Dialogue-Manager-4-ID.git

# 2. Entre na pasta
cd Tutorial-Dialogue-Manager-4-ID

# 3. Abra o Godot e importe o projeto (ou execute o comando abaixo se o Godot estiver no PATH)
godot --editor .
```

### Pulando para uma etapa específica
Se você estiver assistindo à aula e quiser ver o código exato de um momento:
```bash
# Exemplo: ver como foi feita a parte das moedas e condicionais:
git checkout slice-03-estado-e-condicionais

# Voltar para a versão final completa:
git checkout main
```

---

## 🎮 Controles

- **Andar:** `W, A, S, D` ou `Setas`
- **Conversar / Interagir:** Tecla `E` ou `Barra de Espaço`
- **Avançar Diálogo:** `Espaço`, `Enter` ou `Clique do Mouse`
- **Acelerar Texto:** `ESC` ou `Botão Direito`

---

## 📂 Pastas do Projeto

```text
res://
├── addons/
│   └── dialogue_manager/     # O plugin Dialogue Manager 4 (Nathan Hoad)
├── assets/
│   ├── audio/                # Efeitos sonoros do Kenney (moeda, clique, abertura)
│   └── sprites/              # Sprites do Kenney (Cavaleiro, Guarda, Portão, Chão)
├── cenas/
│   ├── player/               # Herói com animações de idle e walk do Kenney
│   ├── npc/                  # Guarda que vigia o portão e conversa
│   ├── itens/                # Moeda animada que gira e toca som ao pegar
│   ├── portao/               # Portão que abre com som de madeira
│   └── mundo.tscn            # Cenário do jogo (chão, paredes e câmera travada)
├── dialogos/
│   └── guardiao.dialogue     # O arquivo de roteiro com as falas e regras
├── scripts/
│   └── game_state.gd         # Guarda o número de moedas e missões
├── ROTEIRO_AULA.md           # Roteiro didático humanizado para dar aula ou gravar vídeo
└── project.godot
```

---

## 📜 Créditos

- **Arte e Áudio:** [Kenney](https://kenney.nl/assets/category:2D) (Tiny Dungeon, Interface Sounds, UI Pack) — Licença **CC0 (Domínio Público)**.
- **Dialogue Manager 4:** Criado por [Nathan Hoad](https://github.com/nathanhoad/godot_dialogue_manager) — Licença MIT.
- **Roteiro e Estruturação Didática:** GameLab UERJ — Projeto de Iniciação à Docência.
