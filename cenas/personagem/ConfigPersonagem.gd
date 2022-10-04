extends Node2D

onready var node_personagem = $Personagem
onready var node_infos = $informacoesPersonagem
onready var node_inventario = $Inventario
onready var node_status = $MonitorStatus

func _ready():
	_on_SelecaoGuia_selecionou_inventario()
	node_personagem.set_cor(node_infos.get_cor())

func _on_informacoesPersonagem_mudou_cor(cor):
	node_personagem.set_cor(cor)

func _on_Inventario_equipou_item(item: Item):
	node_personagem.equipa_item(item)
	node_infos.carrega_status()

func _on_Inventario_removeu_item(item):
	node_personagem.remove_item(item)
	node_infos.carrega_status()

func _on_SelecaoGuia_selecionou_inventario():
	node_inventario.show()
	node_status.hide()

func _on_SelecaoGuia_selecionou_status():
	node_status.show()
	node_inventario.hide()

func _on_Voltar_button_down():
	Global.volta_do_inventario()
