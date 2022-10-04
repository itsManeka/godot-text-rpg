extends Node2D

onready var dialogo = $Dialogo
onready var animacao_transicao = $AnimacaoTransicao
onready var sprite_lobisomen = $Cenario/Lobisomem
onready var painel_luta = $PainelLuta
onready var background = $Cenario/BG

const ATO_INICIO = "inicio"
const ATO_BARULHO = "barulho"
const ATO_LOBISOMEM = "lobisomem"
const ATO_CORRER = "ato_correr"
const ATO_CORRER_PARA_LUZ = "correr_luz"
const ATO_BATEU_PORTA = "bateu_porta"
const ATO_ENTROU = "entrou"
const ATO_SE_TROCOU = "se_trocou"
const ATO_DORMIU = "dormiu"
const ATO_INVADIU = "invadiu"
const ATO_ESPERAR_AMANHECER = "esperar"
const ATO_SAIR_DA_CASA = "sair_da_casa"
const ATO_INVESTIGAR_TRILHA = "investigar_trilha"
const ATO_RIACHO = "chegou_riacho"
const ATO_CABOCLO = "caboclodagua"

var ato = ATO_INICIO
var dialogo_finalizou
var como_terminou_batalha = ""
var botoes_dinamicos = []
var pegou_itens = false

export(Array, String, MULTILINE) var dialogos_lobisomem_1 : Array = []
export(Array, String, MULTILINE) var dialogos_lobisomem_2 : Array = []
export(Array, String, MULTILINE) var dialogos_corrida : Array = []
export(Array, String, MULTILINE) var dialogos_encontrou_casa : Array = []
export(Array, String, MULTILINE) var dialogos_bateu_porta : Array = []
export(Array, String, MULTILINE) var dialogos_conversa_com_velho : Array = []
export(Array, String, MULTILINE) var dialogo_apos_se_trocar : Array = []
export(Array, String, MULTILINE) var dialogo_acordou : Array = []
export(Array, String, MULTILINE) var dialogo_invadiu : Array = []
export(Array, String, MULTILINE) var dialogo_caboclo_1 : Array = []
export(Array, String, MULTILINE) var dialogo_caboclo_2 : Array = []

var monstro_lobisomem: Monstro = null
var monstro_caboclo: Monstro = null

func _ready():
	pass

func mostra_dialogo():
	monstro_lobisomem = MonstroManager.get_monstro_por_id(Enums.MONSTRO_ID.LOBISOMEM)
	monstro_caboclo = MonstroManager.get_monstro_por_id(Enums.MONSTRO_ID.CABOCLO_DAGUA)
	dialogo.play()

func _on_Dialogo_clicou_botao(indice):
	if ato == ATO_INICIO:
		if indice == 0:
			ato = ATO_CORRER_PARA_LUZ
			dialogo.reset(dialogos_encontrou_casa, ["Bater na porta", "Invadir"])
			animacao_transicao.play("Andar")
		elif indice == 1:
			ato = ATO_BARULHO
			dialogo.reset(dialogos_lobisomem_1, [])
			dialogo.play()
	elif ato == ATO_BARULHO:
		if dialogo_finalizou:
			animacao_transicao.play("ApareceuLobsomem")
			ato = ATO_LOBISOMEM
			dialogo.reset(dialogos_lobisomem_2, ["Lutar", "Correr"])
			dialogo.play()
	elif ato == ATO_LOBISOMEM:
		if indice == 0:
			painel_luta.set_dados_batalha(monstro_lobisomem)
			sprite_lobisomen.hide()
			animacao_transicao.play("PlayBatalhaMonstro")
		elif indice == 1:
			ato = ATO_CORRER
			dialogo.reset(dialogos_corrida, ["Correr em direção a luz."])
			dialogo.play()
	elif ato == ATO_CORRER:
		if indice == 0:
			sprite_lobisomen.hide()
			ato = ATO_CORRER_PARA_LUZ
			dialogo.reset(dialogos_encontrou_casa, ["Bater na porta", "Invadir"])
			animacao_transicao.play("Andar")
	elif ato == ATO_CORRER_PARA_LUZ:
		if indice == 0:
			ato = ATO_BATEU_PORTA
			dialogo.reset(dialogos_bateu_porta, ["Entrar"])
			dialogo.play()
		if indice == 1:
			ato = ATO_INVADIU
			animacao_transicao.play("ApagaETrocaBG")
	elif ato == ATO_BATEU_PORTA:
		if indice == 0:
			ato = ATO_ENTROU
			animacao_transicao.play("ApagaETrocaBG")
	elif ato == ATO_ENTROU:
		if indice == 0:
			Global.muda_para_inventario()
	elif ato == ATO_SE_TROCOU:
		if indice == 0:
			ato = ATO_DORMIU
			animacao_transicao.play("ApagaETrocaBG")
	elif ato == ATO_DORMIU:
		if indice == 0:
			DadosPersonagem.set_item_arma_1(ItemManager.get_item_por_id(Enums.ITEM_ID.FACAO))
			dialogo.reset(["Você vasculha a casa e acaba encontrando um facão enferrujado caído em um canto. Talvez seja útil.",\
						   "Item [g]Facão enferrujado[/g] equipado"], [], true)
			dialogo.play()
		elif indice == 1:
			dialogo.reset(["Você investiga a casa para ter mais informações e acaba notando algumas manchas de sangue muito velhas espalhadas.", \
						   "Você também acha um retrato muito empoeirado e ao limpar a poeira ve um homem , uma mulher, ambos idosos, e um adolescente.", \
						   "O homem idoso se parece muito com o senhor que o abrigou. Você vira o retrato e ve uma data.\nO retrato é muito antigo."], [], true)
			dialogo.play()
		elif indice == 2:
			dialogo.reset(["Você chama pelo senhor que outrora estava ali, mas ninguém responde."], [], true)
			dialogo.play()
		elif indice == 3:
			ato = ATO_INVESTIGAR_TRILHA
			animacao_transicao.play("ApagaETrocaBG")
	elif ato == ATO_INVADIU:
		if indice == 0:
			DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CALCA_VELHA))
			DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CAMISA_VELHA))
			DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CHINELOS_VELHOS))
			DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.FACAO))
			pegou_itens = true
			
			dialogo.reset(["Você vasculha a casa e acaba encontrando um facão enferrujado caído em um canto. Talvez seja útil.",\
						   "Item [g]Facão enferrujado[/g] adicionado no inventário.",\
						   "Você continua procurado e acaba encontrando um baú. O baú contém algumas roupas velhas.",\
						   "Item [g]Calça velha[/g] adicionado no inventário.\nItem [g]Camisa velha[/g] adicionado no inventário.\nItem [g]Chinelos velhos[/g] adicionado no inventário."], [], true)
			dialogo.play()
		elif indice == 1:
			ato = ATO_ESPERAR_AMANHECER
			var botoes = []
			if pegou_itens:
				botoes.append("Se vestir")
			botoes.append("Esperar amanhecer")
			dialogo.reset(["Você da uma olhada pela casa e encontra uma janela para a parte de trás.",\
						   "Pelas frestas da janela você vê um caminho. Não é possível ter certaza por conta da escurião, mas parece uma trilha.",\
						   "Melhor investigar ao amanhecer, talvez a trilha chegue a alguma vila."], botoes)
			dialogo.play()
	elif ato == ATO_ESPERAR_AMANHECER:
		if pegou_itens:
			if indice == 0:
				Global.muda_para_inventario()
				return
		if indice == 0 or indice == 1:
			ato = ATO_SAIR_DA_CASA
			dialogo.reset(["Você nota os primeiros raios do dia entrando pelas rachaduras da casa. É hora de partir."], ["investigar a trilha"])
			dialogo.play()
	elif ato == ATO_SAIR_DA_CASA:
		if indice == 0:
			ato = ATO_INVESTIGAR_TRILHA
			animacao_transicao.play("ApagaETrocaBG")
	elif ato == ATO_INVESTIGAR_TRILHA:
		if indice == 0:
			ato = ATO_RIACHO
			animacao_transicao.play("AndaApagaETrocaBG")
	elif ato == ATO_RIACHO:
		if indice == 0:
			ato = ATO_CABOCLO
			dialogo.reset(dialogo_caboclo_1, ["Luta para sobreviver"])
			dialogo.play()
		elif indice == 1:
			ato = ATO_CABOCLO
			dialogo.reset(dialogo_caboclo_2, ["Luta para sobreviver"])
			dialogo.play()
	elif ato == ATO_CABOCLO:
		if indice == 0:
			painel_luta.set_dados_batalha(monstro_caboclo)
			animacao_transicao.play("PlayBatalhaMonstro")
		
func troca_bg():
	if ato == ATO_ENTROU:
		DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CALCA_VELHA))
		DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CAMISA_VELHA))
		DadosPersonagem.add_item_inventario(ItemManager.get_item_por_id(Enums.ITEM_ID.CHINELOS_VELHOS))
		dialogo.reset(dialogos_conversa_com_velho, ["Se vestir"])
		background.texture = load("res://assets/bgs/bg_velho.png")
	elif ato == ATO_DORMIU:
		DadosPersonagem.dormiu()
		botoes_dinamicos = ["Vasculhar casa", "Olhar ao redor", "Chamar por alguém", "Sair para a trilha"]
		dialogo.reset(dialogo_acordou, botoes_dinamicos)
		background.texture = load("res://assets/bgs/bg_velho_antigo.png")
	elif ato == ATO_INVADIU:
		DadosPersonagem.add_status(StatusManager.get_status_por_id(Enums.STATUS_ID.CANSADO))
		botoes_dinamicos = ["Vasculhar casa", "Olhar ao redor"]
		dialogo.reset(dialogo_invadiu, botoes_dinamicos)
		background.texture = load("res://assets/bgs/bg_velho_antigo.png")
	elif ato == ATO_INVESTIGAR_TRILHA:
		dialogo.reset(["Você encontra a trilha..."], ["Seguir trilha"])
		background.texture = load("res://assets/bgs/trilha.png")
	elif ato == ATO_RIACHO:
		dialogo.reset(["Caminhando pela trilha você se depara com um riacho.\nVocê lembra que faz tempo que não bebe água.\nO que você faz?"], ["Beber do riacho", "Continuar a trilha"])
		background.texture = load("res://assets/bgs/trilha_riacho.png")
		
func terminou_transicao():
	if ato == ATO_ENTROU:
		dialogo.play()
	if ato == ATO_DORMIU:
		dialogo.play()
	if ato == ATO_INVADIU:
		dialogo.play()
	if ato == ATO_INVESTIGAR_TRILHA:
		dialogo.play()
	if ato == ATO_RIACHO:
		dialogo.play()

func encontrou_casa():
	print("encontrou_casa")
	background.texture = load("res://assets/bgs/floresta_casa.png")
	
	dialogo.play()

func mostra_monstro():
	sprite_lobisomen.texture = monstro_lobisomem.get_sprite()
	sprite_lobisomen.show()

func _on_Dialogo_finalizou():
	dialogo_finalizou = true

func _on_Dialogo_resetou():
	dialogo_finalizou = false

func _on_PainelLuta_terminou_batalha(como):
	como_terminou_batalha = como
	
	match como_terminou_batalha:
		Enums.TERMINOU_BATALHA_DERROTA:
			if ato == ATO_LOBISOMEM or ato == ATO_CABOCLO:
				get_tree().change_scene("res://cenas/cenarios/floresta/Floresta.tscn")
				return
		Enums.TERMINOU_BATALHA_FUGIR:
			if ato == ATO_LOBISOMEM:
				dialogo.reset(dialogos_corrida, ["Correr em direção a luz."])
		Enums.TERMINOU_BATALHA_VITORIA:
			pass
		
	animacao_transicao.play("PosBatalha")
	
func continua_apos_batalha():
	match como_terminou_batalha:
		Enums.TERMINOU_BATALHA_DERROTA:
			pass
		Enums.TERMINOU_BATALHA_FUGIR:
			if ato == ATO_LOBISOMEM:
				ato = ATO_CORRER
				dialogo.play()
			if ato == ATO_CABOCLO:
				dialogo.reset(["O jogo foi desenvolvido só até aqui. Vlw. Noix!"], ["Botão placebo"])
				dialogo.play()
		Enums.TERMINOU_BATALHA_VITORIA:
			if ato == ATO_CABOCLO:
				dialogo.reset(["O jogo foi desenvolvido só até aqui. Vlw. Noix!"], ["Botão placebo"])
				dialogo.play()

func volta_para_cena():
	if ato == ATO_ENTROU:
		ato = ATO_SE_TROCOU
		dialogo.reset(dialogo_apos_se_trocar, ["Dormir"])
		dialogo.play()
