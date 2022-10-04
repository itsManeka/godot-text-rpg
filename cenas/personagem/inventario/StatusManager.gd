extends Node2D

func get_status_por_nome(nome):
	for i in get_children():
		var status = i as Status
		if status.get_nome() == nome:
			return status.duplicate()

func get_status_por_id(id):
	for i in get_children():
		var status = i as Status
		if status.get_id() == id:
			return status.duplicate()
