extends Control

onready var lista = $HBoxContainer/ItemList
onready var nome = $HBoxContainer/VBoxContainer/ContainerNome/Nome
onready var tipo = $HBoxContainer/VBoxContainer/ContainerTipo/Tipo
onready var origem = $HBoxContainer/VBoxContainer/ContainerOrig/Origem
onready var descricao = $HBoxContainer/VBoxContainer/Descricao

func _ready():
	var tem = false
	for s in DadosPersonagem.get_lista_status():
		tem = true
		s = s as Status
		
		lista.add_item(s.get_nome())
	
	if tem:
		lista.select(0)
		_on_ItemList_item_selected(0)

func _on_ItemList_item_selected(index):
	var status: Status = DadosPersonagem.get_status(index)
	
	nome.text = status.get_nome()
	tipo.text = status.get_tipo_status_texto()
	origem.text = status.get_origem()
	descricao.text = status.get_descricao()
