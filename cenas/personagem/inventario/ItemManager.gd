extends Node2D

func get_item_por_nome(nome):
	for i in get_children():
		var item = i as Item
		if item.get_nome() == nome:
			return item.duplicate()

func get_item_por_id(id):
	for i in get_children():
		var item = i as Item
		if item.get_id() == id:
			return item.duplicate()
