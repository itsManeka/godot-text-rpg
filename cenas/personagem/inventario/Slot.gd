extends Panel
class_name Slot

signal clicou_item(item, slot)

onready var icone_item = $IconeItem

var item: Item
var node_inventario = null
var trocou = true

func _ready():
	node_inventario = find_parent("Inventario")

func _process(delta):
	if trocou:
		if item:
			icone_item.texture = item.get_icone()
		else:
			icone_item.texture = null
		trocou = false

func set_item(_item: Item):
	item = _item
	trocou = true

func get_item() -> Item:
	return item

func _on_TouchScreenButton_pressed():
	if node_inventario and item:
		emit_signal("clicou_item", item, self)

func is_vazio() -> bool:
	if !item:
		return true
	return false
