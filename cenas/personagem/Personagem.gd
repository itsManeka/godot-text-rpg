extends Node2D

onready var node_corpo = $Corpo
onready var sprite_capacete = $Armadura/SpriteCabeca
onready var sprite_calca = $Armadura/SpriteCalca
onready var sprite_peito = $Armadura/SpritePeito
onready var sprite_luvas = $Armadura/SpriteLuvas
onready var sprite_botas = $Armadura/SpriteBotas
onready var sprite_arma_esquerda = $Armas/MaoEsquerda
onready var sprite_arma_direita = $Armas/MaoDireita

var cor

const NAO_INFORMADO = 0
const ARMA_ESQUERDA = 1
const ARMA_DIREITA  = 2 

func _ready():
	seta_dados_personagem()
	
func seta_dados_personagem():
	node_corpo.modulate = DadosPersonagem.get_cor()
	cor = node_corpo.modulate
	
	equipa_item(DadosPersonagem.get_item_arma_1(), ARMA_ESQUERDA)
	equipa_item(DadosPersonagem.get_item_arma_2(), ARMA_DIREITA)
	equipa_item(DadosPersonagem.get_item_botas())
	equipa_item(DadosPersonagem.get_item_cabeca())
	equipa_item(DadosPersonagem.get_item_calca())
	equipa_item(DadosPersonagem.get_item_luvas())
	equipa_item(DadosPersonagem.get_item_peito())
	
func _process(delta):
	node_corpo.modulate = cor

func set_cor(_cor):
	cor = _cor

func equipa_item(item: Item, arma := 0):
	var sprite
	
	if !item:
		return
		
	match item.get_tipo_item():
		Enums.TIPO_ITEM.Capacete:
			sprite = sprite_capacete
		Enums.TIPO_ITEM.Armadura:
			sprite = sprite_peito
		Enums.TIPO_ITEM.Bota:
			sprite = sprite_botas
		Enums.TIPO_ITEM.Luvas:
			sprite = sprite_luvas
		Enums.TIPO_ITEM.Calca:
			sprite = sprite_calca
		Enums.TIPO_ITEM.Arma:
			if arma == ARMA_ESQUERDA:
				sprite = sprite_arma_esquerda
			elif arma == ARMA_DIREITA:
				sprite = sprite_arma_direita
			elif arma == NAO_INFORMADO:
				if !sprite_arma_esquerda.texture:
					sprite = sprite_arma_esquerda
				elif !sprite_arma_direita.texture:
					sprite = sprite_arma_direita
		
	if sprite:
		sprite.texture = item.get_sprite()

func remove_item(item: Item):
	match item.get_tipo_item():
		Enums.TIPO_ITEM.Capacete:
			sprite_capacete.texture = null
		Enums.TIPO_ITEM.Armadura:
			sprite_peito.texture = null
		Enums.TIPO_ITEM.Bota:
			sprite_botas.texture = null
		Enums.TIPO_ITEM.Luvas:
			sprite_luvas.texture = null
		Enums.TIPO_ITEM.Calca:
			sprite_calca.texture = null
