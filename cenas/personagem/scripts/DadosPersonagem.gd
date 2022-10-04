extends Node

var nome
var cor
var classe
var raca
var nivel
var xp

var status = []
var itens_inventario = []
var item_cabeca: Item = null
var item_arma_esq: Item = null
var item_arma_dir: Item = null
var item_peito: Item = null
var item_calca: Item = null
var item_botas: Item = null
var item_luvas: Item = null

func _ready():
	nome = "itsManeka"
	cor = Color("#FFCC99")
	classe = "Guerreiro"
	raca = "Humano"
	nivel = 1
	xp = 0
	
	add_status(StatusManager.get_status_por_id(Enums.STATUS_ID.ATORDOADO))

func add_item_inventario(item: Item):
	itens_inventario.append(item)

func equipa_arma(item: Item):
	if item.get_tipo_item() == Enums.TIPO_ITEM.Arma:
		if !item_arma_esq:
			item_arma_esq = item
			return
		elif !item_arma_dir:
			item_arma_dir = item
			return
	add_item_inventario(item)

func add_status(_status: Status):
	status.append(_status)

func get_nome():
	return nome

func set_nome(_nome):
	nome = _nome

func get_cor():
	return cor

func set_cor(_cor):
	cor = _cor

func get_classe():
	return classe

func get_raca():
	return raca

func get_nivel():
	return nivel

func sobe_nivel(niveis_ganhos: int):
	nivel += niveis_ganhos

func get_xp():
	return xp
	
func soma_xp(xp_ganho: int) -> int:
	var niveis_ganhos = 0
	
	while true:
		if (xp + xp_ganho) >= Global.get_xp_maximo():
			xp_ganho = ((xp + xp_ganho) - Global.get_xp_maximo())
			xp = 0
			sobe_nivel(1)
			niveis_ganhos += 1
		else:
			xp += xp_ganho
			break
	
	return niveis_ganhos

func get_modificadores() -> int:
	return get_modificadores_equip() + get_modificadores_status()
	
func get_modificadores_equip() -> int:
	var forca = 0
	
	if item_cabeca:
		forca += item_cabeca.get_forca()
	if item_arma_esq:
		forca += item_arma_esq.get_forca()
	if item_arma_dir:
		forca += item_arma_dir.get_forca()
	if item_peito:
		forca += item_peito.get_forca()
	if item_calca:
		forca += item_calca.get_forca()
	if item_botas:
		forca += item_botas.get_forca()
	if item_luvas:
		forca += item_luvas.get_forca()
		
	return forca
	
func get_modificadores_status() -> int:
	var forca = 0
	
	for s in status:
		s = s as Status
		forca += s.get_modificador_forca()
	
	return forca

func set_item_cabeca(item: Item):
	item_cabeca = item
	
func get_item_cabeca() -> Item:
	return item_cabeca
	
func set_item_peito(item: Item):
	item_peito = item
	
func get_item_peito() -> Item:
	return item_peito
	
func set_item_botas(item: Item):
	item_botas = item
	
func get_item_botas() -> Item:
	return item_botas
	
func set_item_luvas(item: Item):
	item_luvas = item
	
func get_item_luvas() -> Item:
	return item_luvas
	
func set_item_calca(item: Item):
	item_calca = item
	
func get_item_calca() -> Item:
	return item_calca
	
func set_item_arma_1(item: Item):
	item_arma_esq = item
	
func get_item_arma_1() -> Item:
	return item_arma_esq
	
func set_item_arma_2(item: Item):
	item_arma_dir = item
	
func get_item_arma_2() -> Item:
	return item_arma_dir
	
func remove_item_inventario(item: Item):
	var indice = itens_inventario.find(item)
	if indice >-1:
		itens_inventario.remove(indice)

func get_item_inventario(indice):
	if indice < itens_inventario.size():
		return itens_inventario[indice]

func get_lista_status():
	return status

func get_status(indice) -> Status:
	return status[indice]

func dormiu():
	for s in status:
		s = s as Status
		if s.is_resolve_dormindo():
			status.remove(status.find(s))
