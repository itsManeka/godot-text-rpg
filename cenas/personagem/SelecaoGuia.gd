extends Control

signal selecionou_inventario
signal selecionou_status

onready var botao_inventario = $Inventario
onready var botao_status = $Status

const INVENTARIO = 0
const STATUS = 1

var selecionado = INVENTARIO

func _on_Inventario_pressed():
	botao_inventario.pressed = true
	if selecionado != INVENTARIO:
		selecionado = INVENTARIO
		emit_signal("selecionou_inventario")
		botao_status.pressed = false

func _on_Status_pressed():
	botao_status.pressed = true
	if selecionado != STATUS:
		selecionado = STATUS
		emit_signal("selecionou_status")
		botao_inventario.pressed = false
