# 🎮 RPG de Texto - Folclore Brasileiro

Um RPG de texto desenvolvido em Godot Engine com temática do folclore brasileiro, criado originalmente para a [#1JAM Brazuca](https://itch.io/jam/1jam-brazuca/rate/838732).

![Godot](https://img.shields.io/badge/Godot-3.5-blue?logo=godotengine)
![Status](https://img.shields.io/badge/Status-Prototype-yellow)
![Language](https://img.shields.io/badge/Language-GDScript-brightgreen)

## 📖 Descrição

Este é um protótipo de RPG de texto que combina elementos clássicos de RPG com criaturas e lendas do folclore brasileiro. O jogador embarca em uma aventura pela floresta, enfrentando monstros como Lobisomem e Caboclo d'Água, coletando itens e evoluindo seu personagem.

## ✨ Características

### 🎯 Gameplay
- **Sistema de combate** baseado em turnos
- **Sistema de inventário** completo com equipamentos
- **Sistema de níveis e experiência**
- **Diálogos interativos** com múltiplas escolhas
- **Narrativa ramificada** baseada nas decisões do jogador

### 🎨 Visual
- **Arte pixel art** customizada
- **Interface responsiva** otimizada para resolução 640x360
- **Backgrounds atmosféricos** para diferentes cenários
- **Sprites animados** para personagens e monstros

### 🎭 Temática Brasileira
- **Criaturas do folclore**: Lobisomem, Caboclo d'Água
- **Ambientação rural brasileira**
- **Elementos culturais** integrados à narrativa

## 🚀 Como Jogar

### Pré-requisitos
- [Godot Engine 3.5+](https://godotengine.org/)

### Instalação
1. Clone o repositório:
```bash
git clone https://github.com/itsManeka/godot-text-rpg.git
cd godot-text-rpg
```

2. Abra o projeto no Godot Engine
3. Execute o projeto pressionando F5 ou clicando no botão "Play"

### Controles
- **Mouse**: Interação com botões e interface
- **Decisões**: Escolha opções clicando nos botões de ação

## 🎮 Sistema de Jogo

### Personagem
- **Nome padrão**: itsManeka
- **Classe**: Guerreiro
- **Raça**: Humano
- **Sistema de níveis**: Baseado em experiência (XP)
- **Equipamentos**: Capacetes, armaduras, calças, botas, armas e luvas

### Inventário
- **6 tipos de equipamentos**: Capacete, Armadura, Calça, Bota, Arma, Luvas
- **Sistema de status**: Efeitos passivos, maldições e condições
- **Modificadores**: Itens afetam atributos do personagem

### Combate
- **Sistema baseado em força**: Nível + modificadores de equipamentos
- **Opções de combate**: Lutar, fugir
- **Ganho de XP**: Baseado na diferença de força entre personagem e monstro

## 📁 Estrutura do Projeto

```
├── assets/               # Recursos visuais
│   ├── bgs/             # Backgrounds dos cenários
│   ├── itens/           # Sprites dos itens
│   ├── monstros/        # Sprites dos monstros
│   ├── npcs/            # Sprites dos NPCs
│   └── personagem/      # Sprites do personagem
├── cenas/               # Cenas do jogo
│   ├── cenarios/        # Cenários e interface
│   ├── personagem/      # Sistema do personagem
│   └── monstro/         # Sistema de monstros
└── scripts/             # Scripts globais
    ├── Global.gd        # Gerenciador global
    └── Enums.gd         # Enumerações do jogo
```

## 🛠️ Desenvolvimento

### Arquitetura
- **Autoloads**: Sistemas globais para gerenciamento de estado
- **Managers**: Padrão de gerenciamento para itens, status e monstros
- **Sistema modular**: Cada sistema é independente e reutilizável

### Principais Classes
- `DadosPersonagem`: Gerencia dados do jogador
- `ItemManager`: Sistema de itens e equipamentos
- `MonstroManager`: Gerencia criaturas e combates
- `StatusManager`: Sistema de status e efeitos

### Sistemas Implementados
- ✅ Sistema de diálogo
- ✅ Sistema de combate
- ✅ Sistema de inventário
- ✅ Sistema de experiência
- ✅ Sistema de equipamentos
- ✅ Sistema de status
- ✅ Narrativa ramificada

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 🧑‍💻 Autor

- **Emanuel Ozorio Dias**

## 📞 Contato

- **GitHub**: [@itsManeka](https://github.com/itsManeka)
- **Email**: [emanuel.ozoriodias@gmail.com](mailto:emanuel.ozoriodias@gmail.com)

---

⭐ Se você gostou deste projeto, considere dar uma estrela no repositório!