extends Control

signal terminou_batalha(como)

# Jogador e paineis
onready var label_nome = $PanelPersonagem/VBoxContainer/Nome
onready var label_nivel = $PanelPersonagem/VBoxContainer/BoxNivel/Nivel
onready var label_equp = $PanelPersonagem/VBoxContainer/BoxEquip/Equip
onready var label_status = $PanelPersonagem/VBoxContainer/BoxStatus/Status
onready var label_forca = $PanelPersonagem/VBoxContainer/BoxForca/Forca
onready var lista_status = $PanelPersonagem/VBoxContainer/ListaStatus
onready var personagem = $Personagem

# Monstro e paineis
var monstro: Monstro = null

onready var text_descricao = $PanelMonstro/VBoxContainer/Desc
onready var label_nome_monstro = $PanelMonstro/VBoxContainer/Nome
onready var label_forca_monstro = $PanelMonstro/VBoxContainer/BoxForca/Forca
onready var sprite_monstro = $Monstro

# Geral
onready var animacao = $AnimacaoIniciar

# Painel Ações
onready var botao_fugir = $Acoes/VBoxContainer/Fugir

# Fugir
var resultado_dado_dir = {
	15: 1,
	31: 1,
	3: 2,
	27: 3,
	19: 4,
	11: 5,
	7: 6,
	23: 6
}

onready var painel_fugir = $Fugir
onready var sprite_dado = $Dado
onready var timer_dado = $TimerDado
onready var botao_rolar = $Fugir/BoxFugir/Rolar
onready var desc_rolar = $Fugir/BoxFugir/Desc

var resultado_dado = 0
var resultado_dado_tentou = false

# Resolver
var forca_jogador = 0
var forca_monstro = 0
var vitoria = false

onready var sprite_espadas = $Espadas

# Vitoria
onready var painel_vitoria = $PainelVitoria
onready var label_exp_ini = $PainelVitoria/BoxFugir/HBoxContainer/ExpIni
onready var label_exp_fin = $PainelVitoria/BoxFugir/HBoxContainer/ExpFin
onready var barra_progresso_exp = $PainelVitoria/BoxFugir/HBoxContainer/ProgressBar
onready var mensagens_vitoria = $PainelVitoria/BoxFugir/MensagensVitoria

# Derrota
onready var painel_derrota = $PainelDerrota
onready var coisa_ruim = $PainelDerrota/BoxFugir/CoisaRuim

func _ready():
	sprite_espadas.hide()
	sprite_dado.hide()
	painel_fugir.hide()
	painel_vitoria.hide()
	painel_derrota.hide()
	hide()
	
	# set_dados_batalha(MonstroManager.get_monstro_por_id(Enums.MONSTRO_ID.LOBISOMEM))
	# inicia_batalha()

func set_dados_batalha(_monstro: Monstro):
	sprite_dado.scale = Vector2(1, 1)
	resultado_dado = 0
	resultado_dado_tentou = false

	desc_rolar.show()
	botao_rolar.show()
	monstro = _monstro
	
	set_dados_jogador()
	set_dados_monstro()
	
func inicia_batalha():
	animacao.play("Iniciar")
	
func set_dados_jogador():
	personagem.seta_dados_personagem()
	
	label_nome.text = DadosPersonagem.get_nome()
	label_nivel.text = str(DadosPersonagem.get_nivel())
	label_status.text = str(DadosPersonagem.get_modificadores_status())
	label_equp.text = str(DadosPersonagem.get_modificadores_equip())
	
	lista_status.clear()
	for i in DadosPersonagem.get_lista_status():
		i = i as Status
		lista_status.add_item(i.get_nome())
	
	forca_jogador = DadosPersonagem.get_nivel() + DadosPersonagem.get_modificadores()
	label_forca.text = str(forca_jogador)

func set_dados_monstro():
	if monstro:
		text_descricao.bbcode_text = monstro.get_descricao() + \
									"\n\nCoisa Ruim:\n" + \
									monstro.get_descricao_coisa_ruim()
		label_nome_monstro.text = monstro.get_nome()
		sprite_monstro.texture = monstro.get_sprite()
		
		forca_monstro = monstro.get_forca()
		label_forca_monstro.text = str(forca_monstro)

func _on_Resolver_button_down():
	animacao.play("AnimacaoEspadas")

func terminou_animacao_espadas():
	vitoria = forca_jogador > forca_monstro
	if vitoria:
		calcula_progresso_exp()
		
		animacao.play("MonstroDerrota")
	else:
		coisa_ruim.bbcode_text = monstro.get_descricao_coisa_ruim()
		
		animacao.play("JogadorDerrota")

func play_animacao_derrota_vitoria():
	animacao.play("MostraPainelDerrotaVitoria")

func mostrou_tela_derrota_vitoria():
	if vitoria:
		painel_vitoria.visible = true
	else:
		painel_derrota.visible = true

func calcula_progresso_exp():
	var xp_ganho = Global.calcula_xp_ganho(monstro.get_forca())
	var niveis_ganhos = DadosPersonagem.soma_xp(xp_ganho)
	
	label_exp_ini.text = str(DadosPersonagem.get_xp())
	label_exp_fin.text = str(Global.get_xp_maximo())
	
	barra_progresso_exp.max_value = Global.get_xp_maximo()
	barra_progresso_exp.value = DadosPersonagem.get_xp()
	
	mensagens_vitoria.add_item("Ganhou " + str(xp_ganho) + " de experiência.")
	if niveis_ganhos > 0:
		mensagens_vitoria.add_item("Subiu " + str(niveis_ganhos) + " niveis.")

func _on_Fugir_button_down():
	painel_fugir.show()

func _on_Rolar_button_down():
	resultado_dado = randi()%6+1
	sprite_dado.frame = randi()%32
	desc_rolar.hide()
	botao_rolar.hide()
	sprite_dado.show()
	timer_dado.start(0.05)
	
func resolve_resultado_fugir():
	sprite_dado.hide()
	
	if resultado_dado < 5:
		botao_fugir.disabled = true
		painel_fugir.hide()
	else:
		animacao.play("Fugiu")

func terminou_animacao_paineis_fugir():
	emit_signal("terminou_batalha", Enums.TERMINOU_BATALHA_FUGIR)

func _on_TimerDado_timeout():
	var frame = sprite_dado.frame
	frame += 1
	if frame > 31:
		frame = 0
	sprite_dado.frame = frame
	
	if resultado_dado_dir.has(frame):
		if resultado_dado_dir.get(frame) == resultado_dado:
			if randi()%2==0 and !resultado_dado_tentou:
				resultado_dado_tentou = true
				return
			timer_dado.stop()
			animacao.play("RolouDado")

func _on_Continuar_vitoria_button_down():
	painel_vitoria.hide()
	emit_signal("terminou_batalha", Enums.TERMINOU_BATALHA_VITORIA)

func _on_Continuar_derrota_button_down():
	painel_derrota.hide()
	emit_signal("terminou_batalha", Enums.TERMINOU_BATALHA_DERROTA)
