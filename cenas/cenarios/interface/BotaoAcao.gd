extends Button
class_name BotaoAcao

export var inicia_invisivel = true

var indice = null

func _ready():
	if inicia_invisivel:
		hide()

func _mostra_botao():
	show()

func _esconde_botao():
	hide()
	
func set_indice(_indice: int):
	indice = _indice

func get_indice() -> int:
	return indice
