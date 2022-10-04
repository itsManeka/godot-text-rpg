extends Node2D

class_name Item

export(Enums.ITEM_ID) var id
export(Enums.TIPO_ITEM) var tipo_item
export var nome = ""
export(String, MULTILINE) var descricao = ""
export var forca = 0
export(Texture) var item_icon
export(Texture) var item_sprite

var equipado = false

func get_nome():
	return nome

func get_forca():
	return forca

func get_descricao():
	return descricao

func get_tipo_item():
	return tipo_item

func get_tipo_item_texto():
	return Enums.get_texto_tipo_item(tipo_item)
	
func get_id():
	return id

func get_icone() -> Texture:
	return item_icon

func get_sprite() -> Texture:
	return item_sprite

func is_equipado() -> bool:
	return equipado

func set_equipado(_equipado: bool):
	equipado = _equipado
