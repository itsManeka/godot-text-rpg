# 🔧 Documentação Técnica

## 📁 Estrutura de Arquivos

### Organização do Projeto

```
godot-text-rpg/
├── assets/                    # Recursos visuais
│   ├── bgs/                  # Backgrounds dos cenários
│   ├── fontes/               # Fontes customizadas
│   ├── inventario/           # UI do inventário
│   ├── itens/                # Sprites dos itens
│   │   ├── armadura/
│   │   ├── armas/
│   │   ├── botas/
│   │   ├── calcas/
│   │   └── capacetes/
│   ├── monstros/             # Sprites das criaturas
│   ├── npcs/                 # Sprites dos NPCs
│   └── personagem/           # Sprites do personagem
├── cenas/                    # Cenas do Godot
│   ├── cenarios/            # Cenários e interface
│   │   ├── floresta/        # Cena principal
│   │   └── interface/       # Componentes UI
│   ├── dungeon/             # Sistema de dungeons
│   ├── monstro/             # Sistema de monstros
│   └── personagem/          # Sistema do personagem
│       ├── inventario/      # Sistema de inventário
│       └── scripts/         # Scripts do personagem
└── scripts/                 # Scripts globais
```

## 🧩 Sistemas Principais

### 1. Sistema Global (Global.gd)

**Responsabilidades:**
- Gerenciamento de transições entre cenas
- Cálculos globais (XP, níveis)
- Controle do fluxo principal do jogo

**Métodos Principais:**
```gdscript
func get_xp_maximo() -> int
func muda_para_inventario()
func volta_do_inventario()
func calcula_xp_ganho(forca_monstro: int) -> int
```

### 2. Sistema de Dados do Personagem (DadosPersonagem.gd)

**Atributos:**
```gdscript
var nome: String
var cor: Color
var classe: String
var raca: String
var nivel: int
var xp: int
var status: Array
var itens_inventario: Array
# Slots de equipamentos
var item_cabeca: Item
var item_arma_esq: Item
var item_arma_dir: Item
var item_peito: Item
var item_calca: Item
var item_botas: Item
var item_luvas: Item
```

**Métodos Importantes:**
```gdscript
func soma_xp(xp_ganho: int) -> int  # Retorna níveis ganhos
func get_modificadores() -> int     # Força total de equipamentos e status
func equipa_arma(item: Item)       # Sistema de duas armas
func dormiu()                      # Remove status temporários
```

### 3. Sistema de Enumerações (Enums.gd)

**Principais Enums:**
```gdscript
enum TIPO_ITEM {Capacete, Armadura, Calca, Bota, Arma, Luvas}
enum ITEM_ID {CHAPEU_SOVIETICO, CALCA_UNIFORME, BONE_MST, ...}
enum TIPO_STATUS {HABILIDADE_PASSIVA, MALDICAO, CONDICAO}
enum STATUS_ID {ATORDOADO, CANSADO}
enum MONSTRO_ID {LOBISOMEM, CABOCLO_DAGUA}
```

## 🎮 Sistemas de Gameplay

### Sistema de Combate

**Fluxo de Combate:**
1. Inicialização via `PainelLuta.set_dados_batalha(monstro)`
2. Cálculo de forças (personagem vs monstro)
3. Resolução do combate
4. Sinal `terminou_batalha(como)` emitido

**Tipos de Resultado:**
- `TERMINOU_BATALHA_VITORIA`
- `TERMINOU_BATALHA_DERROTA`
- `TERMINOU_BATALHA_FUGIR`

### Sistema de Diálogo

**Componente:** `Dialogo.gd`

**Funcionalidades:**
- Texto formatado com BBCode
- Botões dinâmicos
- Sistema de reset para novos diálogos
- Sinais para interação

**Sinais:**
```gdscript
signal clicou_botao(indice)
signal finalizou()
signal resetou()
```

### Sistema de Inventário

**Gerenciadores:**
- `ItemManager`: Criação e gestão de itens
- `StatusManager`: Gestão de status e efeitos
- `Slot.gd`: Componente visual dos slots

**Classes Principais:**
```gdscript
class Item extends Node2D
class Status extends Node2D
class Slot extends Panel
```

## 🔄 Fluxo de Estados

### Estados da Floresta (Floresta.gd)

O jogo principal utiliza um sistema de estados baseado em strings:

```gdscript
const ATO_INICIO = "inicio"
const ATO_BARULHO = "barulho"
const ATO_LOBISOMEM = "lobisomem"
const ATO_CORRER = "ato_correr"
const ATO_CORRER_PARA_LUZ = "correr_luz"
const ATO_BATEU_PORTA = "bateu_porta"
const ATO_ENTROU = "entrou"
const ATO_SE_TROCOU = "se_trocou"
const ATO_DORMIU = "dormiu"
const ATO_INVADIU = "invadiu"
const ATO_ESPERAR_AMANHECER = "esperar"
const ATO_SAIR_DA_CASA = "sair_da_casa"
const ATO_INVESTIGAR_TRILHA = "investigar_trilha"
const ATO_RIACHO = "chegou_riacho"
const ATO_CABOCLO = "caboclodagua"
```

### Máquina de Estados Simplificada

```gdscript
func _on_Dialogo_clicou_botao(indice):
    match ato:
        ATO_INICIO:
            # Lógica do estado inicial
        ATO_LOBISOMEM:
            # Lógica do combate com lobisomem
        # ... outros estados
```

## 🎨 Sistema Visual

### Configurações de Importação

**Texturas:**
```gdscript
compress/mode = 0          # Sem compressão
detect_3d = false         # 2D apenas
flags/filter = false      # Pixel art sem filtro
flags/mipmaps = false     # Sem mipmaps
```

### Animações

**AnimationPlayer** usado para:
- Transições entre cenários
- Aparição de monstros
- Efeitos de batalha

**Animações Principais:**
- `Andar`: Transição de movimento
- `ApareceuLobsomem`: Aparição do lobisomem
- `PlayBatalhaMonstro`: Entrada em combate
- `PosBatalha`: Retorno pós-combate
- `ApagaETrocaBG`: Transição de cenário

## 🏗️ Padrões de Arquitetura

### Singleton Pattern

Utilizados para sistemas globais:
- `Global`: Gerenciamento geral
- `DadosPersonagem`: Estado do jogador
- `ItemManager`, `StatusManager`, `MonstroManager`: Gerenciadores de recursos

### Observer Pattern

Sistema de sinais do Godot usado extensivamente:
```gdscript
# Exemplo de conexões
dialogo.connect("clicou_botao", self, "_on_Dialogo_clicou_botao")
painel_luta.connect("terminou_batalha", self, "_on_PainelLuta_terminou_batalha")
```

### Factory Pattern

Managers implementam factories para criação de objetos:
```gdscript
# ItemManager
func get_item_por_id(item_id) -> Item

# MonstroManager  
func get_monstro_por_id(monstro_id) -> Monstro

# StatusManager
func get_status_por_id(status_id) -> Status
```

## 🔧 Configurações do Projeto

### Autoloads Configurados

```ini
[autoload]
Global="*res://scripts/Global.gd"
ItemManager="*res://cenas/personagem/inventario/ItemManager.tscn"
StatusManager="*res://cenas/personagem/inventario/StatusManager.tscn"
MonstroManager="*res://cenas/monstro/MonstroManager.tscn"
DadosPersonagem="*res://cenas/personagem/scripts/DadosPersonagem.gd"
```

### Display Settings

```ini
[display]
window/size/width=640
window/size/height=360
window/stretch/mode="2d"
```

## 🐛 Debug e Desenvolvimento

### Logs e Debug

- `print()` statements para debug básico
- Estados do jogo logados para tracking
- Métodos de debug em desenvolvimento

### Ferramentas de Desenvolvimento

**Godot Remote Inspector:**
- Monitoramento em tempo real
- Debug de nós e propriedades
- Performance profiling

## 📋 Checklist para Novos Desenvolvedores

### Setup Inicial
- [ ] Instalar Godot 3.5+
- [ ] Clonar repositório
- [ ] Configurar projeto no Godot
- [ ] Testar execução básica

### Familiarização com Código
- [ ] Estudar `Global.gd` e `DadosPersonagem.gd`
- [ ] Entender sistema de estados em `Floresta.gd`
- [ ] Explorar managers (Item, Status, Monstro)
- [ ] Testar sistema de inventário

### Contribuição
- [ ] Ler documentação de design
- [ ] Configurar ambiente de debug
- [ ] Executar testes básicos

