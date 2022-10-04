extends Node2D

onready var nome = $Nome
onready var raca = $Raca
onready var classe = $Classe
onready var cor = $Cor
onready var xp = $Exp
onready var nivel = $Nivel
onready var forca = $Forca
onready var modificadores = $Mod

signal mudou_cor(cor)

func _ready():
	nome.text = DadosPersonagem.get_nome()
	raca.text = DadosPersonagem.get_raca()
	classe.text = DadosPersonagem.get_classe()
	cor.color = DadosPersonagem.get_cor()
	
	carrega_status()
	
	set_campo_xp()
	
	ajusta_color_picker(cor.get_picker())

func carrega_status():
	nivel.text = str(DadosPersonagem.get_nivel())
	modificadores.text = str(DadosPersonagem.get_modificadores())
	forca.text = str(DadosPersonagem.get_modificadores() + DadosPersonagem.get_nivel())

func ajusta_color_picker(ctrl):
	for child in ctrl.get_children():
		if child is SpinBox:
			child.hide()
		if child is HSlider:
			child.hide()
		if child is Label:
			child.hide()
		if child is Button:
			child.hide()
			
		if child is Container:
			ajusta_color_picker(child)

func _on_Cor_color_changed(_cor):
	emit_signal("mudou_cor", _cor)
	DadosPersonagem.set_cor(_cor)

func _on_Nome_text_changed(_nome):
	DadosPersonagem.set_nome(_nome)

func set_campo_xp():
	var texto
	
	texto = str(Global.get_xp_maximo())
	
	xp.text = texto

func get_cor():
	return cor.color
