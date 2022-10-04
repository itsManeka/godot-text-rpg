extends Node2D

func get_monstro_por_id(id):
	for i in get_children():
		var monstro = i as Monstro
		if monstro.get_id() == id:
			return monstro.duplicate()
