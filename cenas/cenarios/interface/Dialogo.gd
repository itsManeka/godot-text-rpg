extends Panel

signal finalizou
signal resetou
signal clicou_botao(indice)

onready var texto = $VBoxContainer/Texto
onready var botao_continuar = $VBoxContainer/Botoes/Continuar
onready var container_botoes = $VBoxContainer/Botoes/BotoesAcao
onready var timer = $Timer

var botao_acao = preload("res://cenas/cenarios/interface/BotaoAcao.tscn")
var fonte_botao = preload("res://cenas/cenarios/interface/FonteBotao.tres")

export var tempo_espera = 0.05
export var autoplay = true
export(Array, String, MULTILINE) var dialogos : Array = []
export(Array, String) var botoes_de_acao : Array = []

var indice_texto = -1

func _ready():
	botao_continuar.connect("button_down", self, "_clicou_botao", [-1])
	
	inicia()
		
func inicia():
	ajusta_bbcodes()
	cria_botoes()
	proximo_dialogo()
	
	if autoplay:
		timer.start(tempo_espera)

func play():
	timer.start(tempo_espera)

func reset(novos_dialogos, novos_botoes_de_acao := [], mantem_botoes := false):
	emit_signal("resetou")
	
	botao_continuar.show()
	dialogos = novos_dialogos
	
	botoes_de_acao = novos_botoes_de_acao
	if !mantem_botoes:
		for c in container_botoes.get_children():
			container_botoes.remove_child(c)
			
	indice_texto = -1
	
	inicia()

func ajusta_bbcodes():
	for i in range(dialogos.size()):
		dialogos[i] = dialogos[i].replace("[r]", "[color=#d81c1c]")
		dialogos[i] = dialogos[i].replace("[/r]", "[/color]")
		dialogos[i] = dialogos[i].replace("[b]", "[color=#3a2fbc]")
		dialogos[i] = dialogos[i].replace("[/b]", "[/color]")
		dialogos[i] = dialogos[i].replace("[g]", "[color=#51d672]")
		dialogos[i] = dialogos[i].replace("[/g]", "[/color]")
		dialogos[i] = dialogos[i].replace("[/p]", "[color=#3a2fbc]" + DadosPersonagem.get_nome() + "[/color]")

func cria_botoes():
	var indice = -1
	for i in botoes_de_acao:
		indice += 1
		var botao : BotaoAcao = botao_acao.instance()
		connect("finalizou", botao, "_mostra_botao")
		connect("resetou", botao, "_esconde_botao")
		botao.text = i
		botao.set_indice(indice)
		botao.connect("button_down", self, "_clicou_botao", [botao.get_indice()])
		container_botoes.add_child(botao)

func _clicou_botao(indice: int):
	if indice > -1:
		for b in container_botoes.get_children():
			b = b as BotaoAcao
			if b.get_indice() == indice:
				container_botoes.remove_child(b)
				var find = botoes_de_acao.find(b.text)
				if find > -1:
					botoes_de_acao.remove(find)
				break
	emit_signal("clicou_botao", indice)

func _on_Timer_timeout():
	if texto:
		texto.visible_characters += 1
	
	if texto.visible_characters > texto.get_total_character_count():
		if indice_texto == dialogos.size() -1:
			if container_botoes.get_child_count() > 0:
				botao_continuar.hide()
			timer.stop()
			emit_signal("finalizou")

func _on_Continuar_button_down():
	if texto.visible_characters > texto.get_total_character_count():
		if indice_texto < dialogos.size() - 1:
			proximo_dialogo()
	else:
		texto.visible_characters = texto.get_total_character_count()

func proximo_dialogo():
	indice_texto += 1
	if indice_texto <= dialogos.size() - 1:
		texto.bbcode_text = dialogos[indice_texto]
		
		var posicao_inicial = texto.text.find(":")
		texto.visible_characters = posicao_inicial + 1
