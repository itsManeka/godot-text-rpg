extends Node2D
class_name Status

export(Enums.STATUS_ID) var id
export(Enums.TIPO_STATUS) var tipo
export var nome = ""
export(String, MULTILINE) var descricao = ""
export var modificador_forca = 0
export var modificador_fugir = 0
export var resolve_dormindo = false

var origem = null

func get_nome() -> String:
	return nome

func get_descricao() -> String:
	return descricao

func get_tipo_status():
	return tipo

func get_id():
	return id

func get_tipo_status_texto():
	return Enums.get_texto_tipo_status(tipo)

func get_modificador_forca() -> int:
	return modificador_forca

func get_modificador_fugir() -> int:
	return modificador_fugir

func get_origem() -> String:
	if origem:
		if origem.has_method("get_nome"):
			return origem.get_nome()
	return "Diversas"

func is_resolve_dormindo():
	return resolve_dormindo
