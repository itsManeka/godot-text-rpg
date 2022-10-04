extends Control

signal equipou_item(item)
signal removeu_item(item)

onready var grid_inventario = $Inventario
onready var menu_item = $ItemMenu
onready var slot_capacete = $Equipado/Capacete
onready var slot_calca = $Equipado/Calcas
onready var slot_arma_1 = $Equipado/Arma1
onready var slot_arma_2 = $Equipado/Arma2
onready var slot_botas = $Equipado/Botas
onready var slot_luvas = $Equipado/Luvas
onready var slot_armadura = $Equipado/Armadura

var pre_slot = preload("res://cenas/personagem/inventario/Slot.tscn")

var slot_selecionado: Slot = null

export var linhas_inventario = 3

func _ready():
	gera_inventario()
	menu_item.hide()

func gera_inventario():
	for i in range(linhas_inventario * grid_inventario.columns):
		var slot = pre_slot.instance()
		slot.set_item(DadosPersonagem.get_item_inventario(i))
		slot.connect("clicou_item", self, "_on_clicou_item")
		grid_inventario.add_child(slot)
		
func mostra_item_menu(item: Item):
	if get_global_mouse_position().y + menu_item.rect_size.y > get_viewport_rect().size.y:
		menu_item.rect_position = get_local_mouse_position()
		menu_item.rect_position.y -= get_global_mouse_position().y + menu_item.rect_size.y - get_viewport_rect().size.y
	else:
		menu_item.rect_position = get_local_mouse_position()
	menu_item.mostra_menu(item)

func _on_clicou_item(item, slot):
	slot_selecionado = slot
	mostra_item_menu(item)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if !slot_selecionado:
				return
			if menu_item.visible and \
				(get_global_mouse_position().x > menu_item.rect_global_position.x) and \
				(get_global_mouse_position().x < menu_item.rect_global_position.x + menu_item.rect_size.x) and \
			 	(get_global_mouse_position().y > menu_item.rect_global_position.y) and \
			 	(get_global_mouse_position().y < menu_item.rect_global_position.y + menu_item.rect_size.y):
				return
			if (get_global_mouse_position().x < slot_selecionado.rect_global_position.x) or \
				(get_global_mouse_position().x > slot_selecionado.rect_global_position.x + slot_selecionado.rect_size.x) or\
			 	(get_global_mouse_position().y < slot_selecionado.rect_global_position.y) or \
			 	(get_global_mouse_position().y > slot_selecionado.rect_global_position.y + slot_selecionado.rect_size.y):
				menu_item.fecha_menu()

func _on_ItemMenu_fechou():
	slot_selecionado = null

func _on_ItemMenu_equipou(item: Item):
	var item_aux = null
	var pode_equipar = false
	
	if Enums.TIPO_ITEM.values().has(item.get_tipo_item()):
		item.set_equipado(true)
		pode_equipar = true
			
	match item.get_tipo_item():
		Enums.TIPO_ITEM.Capacete:
			if !slot_capacete.is_vazio():
				item_aux = slot_capacete.get_item()
			slot_capacete.set_item(item)
			DadosPersonagem.set_item_cabeca(item)
		Enums.TIPO_ITEM.Calca:
			if !slot_calca.is_vazio():
				item_aux = slot_calca.get_item()
			slot_calca.set_item(item)
			DadosPersonagem.set_item_calca(item)
		Enums.TIPO_ITEM.Bota:
			if !slot_botas.is_vazio():
				item_aux = slot_botas.get_item()
			slot_botas.set_item(item)
			DadosPersonagem.set_item_botas(item)
		Enums.TIPO_ITEM.Luvas:
			if !slot_luvas.is_vazio():
				item_aux = slot_luvas.get_item()
			slot_luvas.set_item(item)
			DadosPersonagem.set_item_luvas(item)
		Enums.TIPO_ITEM.Armadura:
			if !slot_armadura.is_vazio():
				item_aux = slot_armadura.get_item()
			slot_armadura.set_item(item)
			DadosPersonagem.set_item_peito(item)
		Enums.TIPO_ITEM.Arma:
			if slot_arma_1.is_vazio():
				slot_arma_1.set_item(item)
				DadosPersonagem.set_item_arma_1(item)
			elif slot_arma_2.is_vazio():
				slot_arma_2.set_item(item)
				DadosPersonagem.set_item_arma_2(item)
			else:
				item_aux = slot_arma_1.get_item()
				slot_arma_1.set_item(item)
				DadosPersonagem.set_item_arma_1(item)
	
	if pode_equipar:
		slot_selecionado.set_item(null)
		DadosPersonagem.remove_item_inventario(item)
		
		if item_aux:
			for slot in grid_inventario.get_children():
				slot = slot as Slot
				if slot.is_vazio():
					item_aux.set_equipado(false)
					slot.set_item(item_aux)
					break
		
		emit_signal("equipou_item", item)

func _on_ItemMenu_removeu(item: Item):
	slot_selecionado.set_item(null)
	for slot in grid_inventario.get_children():
		slot = slot as Slot
		if slot.is_vazio():
			item.set_equipado(false)
			slot.set_item(item)
			break
	match item.get_tipo_item():
		Enums.TIPO_ITEM.Capacete:
			DadosPersonagem.set_item_cabeca(null)
		Enums.TIPO_ITEM.Calca:
			DadosPersonagem.set_item_calca(null)
		Enums.TIPO_ITEM.Bota:
			DadosPersonagem.set_item_botas(null)
		Enums.TIPO_ITEM.Luvas:
			DadosPersonagem.set_item_luvas(null)
		Enums.TIPO_ITEM.Armadura:
			DadosPersonagem.set_item_peito(null)
	DadosPersonagem.add_item_inventario(item)
	emit_signal("removeu_item", item)

func _on_ItemMenu_descartou(item: Item):
	if !item.is_equipado():
		slot_selecionado.set_item(null)
		DadosPersonagem.remove_item_inventario(item)
	else:
		slot_selecionado.set_item(null)
		match item.get_tipo_item():
			Enums.TIPO_ITEM.Capacete:
				DadosPersonagem.set_item_cabeca(null)
			Enums.TIPO_ITEM.Calca:
				DadosPersonagem.set_item_calca(null)
			Enums.TIPO_ITEM.Bota:
				DadosPersonagem.set_item_botas(null)
			Enums.TIPO_ITEM.Luvas:
				DadosPersonagem.set_item_luvas(null)
			Enums.TIPO_ITEM.Armadura:
				DadosPersonagem.set_item_peito(null)
	emit_signal("removeu_item", item)
	item.queue_free()
