extends PanelContainer

signal equipou(item)
signal removeu(item)
signal descartou(item)
signal fechou

onready var nome = $VBoxContainer/Nome
onready var tipo = $VBoxContainer/HBoxContainer/Tipo
onready var forca = $VBoxContainer/HBoxContainer2/Forca
onready var descricao = $VBoxContainer/Descricao
onready var botao_equipar = $VBoxContainer/HBoxContainer3/Equipar

var item: Item = null

func mostra_menu(_item: Item):
	item = _item
	if item:
		nome.text = item.get_nome()
		tipo.text = item.get_tipo_item_texto()
		forca.text = str(item.get_forca())
		descricao.text = item.get_descricao()
		
		if item.equipado:
			botao_equipar.text = "Remover"
		else:
			botao_equipar.text = "Equipar"
		
		show()

func fecha_menu():
	emit_signal("fechou")
	hide()
	item = null

func _on_Equipar_button_down():
	if item.equipado:
		emit_signal("removeu", item)
	else:
		emit_signal("equipou", item)
	fecha_menu()

func _on_Descartar_button_down():
	emit_signal("descartou", item)
	fecha_menu()
