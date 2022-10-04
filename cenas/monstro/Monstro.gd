extends Node2D

class_name Monstro

export(Enums.MONSTRO_COISA_RUIM) var coisa_ruim
export(Enums.MONSTRO_ID) var id
export var nome = ""
export(String, MULTILINE) var descricao = ""
export(String, MULTILINE) var descricao_coisa_ruim = ""
export var forca = 0
export(Texture) var sprite

func get_sprite() -> Texture:
	return sprite

func get_id():
	return id

func get_nome() -> String:
	return nome

func get_descricao_coisa_ruim() -> String:
	return descricao_coisa_ruim

func get_descricao() -> String:
	return descricao

func get_forca() -> int:
	return forca
