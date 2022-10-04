extends Node

var root = null
var cena_jogo = null

func _ready():
	randomize()
	root = get_tree().get_root()

func get_xp_maximo():
	return 90 + (100 * (float(DadosPersonagem.get_nivel()) / 10))

func muda_para_inventario():
	var cena_inventario = load("res://cenas/personagem/ConfigPersonagem.tscn").instance()
	cena_jogo = get_tree().get_current_scene()
	root.add_child(cena_inventario)
	get_tree().set_current_scene(cena_inventario)
	root.remove_child(cena_jogo)

func volta_do_inventario():
	root.remove_child(get_tree().get_current_scene())
	root.add_child(cena_jogo)
	get_tree().set_current_scene(cena_jogo)
	if cena_jogo.has_method("volta_para_cena"):
		cena_jogo.volta_para_cena()

func calcula_xp_ganho(forca_monstro: int) -> int:
	var xp = 0
	var nivel_personagem = DadosPersonagem.get_nivel()
	
	xp = (((forca_monstro - nivel_personagem) / 2) * 10)
	
	return xp
