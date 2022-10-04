extends Node

class_name Enums

const TERMINOU_BATALHA_VITORIA = "vitoria"
const TERMINOU_BATALHA_DERROTA = "derrota"
const TERMINOU_BATALHA_FUGIR = "fugir"

enum TIPO_ITEM {Capacete, Armadura, Calca, Bota, Arma, Luvas}
enum ITEM_ID {CHAPEU_SOVIETICO = 0, CALCA_UNIFORME = 1, BONE_MST = 2, CAMISA_VELHA = 3, CALCA_VELHA = 4,\
			  CHINELOS_VELHOS = 5, FACAO = 6}
static func get_texto_tipo_item(tipo_item) -> String:
	match tipo_item:
		TIPO_ITEM.Capacete:
			return "Capacete"
		TIPO_ITEM.Armadura:
			return "Armadura"
		TIPO_ITEM.Calca:
			return "Calça"
		TIPO_ITEM.Bota:
			return "Bota"
		TIPO_ITEM.Arma:
			return "Arma"
		TIPO_ITEM.Luvas:
			return "Luvas"
	return "Outro"

enum TIPO_STATUS {HABILIDADE_PASSIVA, MALDICAO, CONDICAO}
enum STATUS_ID {ATORDOADO = 0, CANSADO = 1}
static func get_texto_tipo_status(tipo_status) -> String:
	match tipo_status:
		TIPO_STATUS.HABILIDADE_PASSIVA:
			return "Passiva"
		TIPO_STATUS.MALDICAO:
			return "Maldição"
		TIPO_STATUS.CONDICAO:
			return "Condição"
	return "Outro"

enum MONSTRO_ID {LOBISOMEM = 0, CABOCLO_DAGUA = 1}
enum MONSTRO_COISA_RUIM {MORTE = 0}
