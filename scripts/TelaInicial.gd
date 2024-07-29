extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int 
var correct: int

#retornar valor do meu index
var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var texture_rect: TextureRect = $Control/VBoxContainer/ColorRect/Panel/TextureRect
@onready var Button_Iniciar: Button = $Control/VBoxContainer/ColorRect/VBoxContainer/ColorRect/Button

@onready var Tela_Pegar_Nome: ColorRect = $Control/ColorRect
@onready var Nome: LineEdit = $Control/ColorRect/LineEdit

@onready var Tela_Informacao: ColorRect = $Control/Tela_Informacao
@onready var mostrar_nome: Label = $Control/Tela_Informacao/Label
@onready var Iniciar_Jogo: Button = $Control/Tela_Informacao/ColorRect3/Button

@onready var Jogo: ColorRect = $Control/Jogo
@onready var descricao: Label = $Control/Jogo/Label
@onready var descricao_scr: Label = $Control/Jogo/ColorRect2/TextureRect/Label

@onready var Game_Over: ColorRect = $Control/Game_Over
@onready var descFinal: Label = $Control/Game_Over/Desc



func _ready():
	correct = 0
	var img_texture = preload("res://imgs/TelaInicial.jpg")
	texture_rect.texture = img_texture
	Tela_Pegar_Nome.hide()
	Tela_Informacao.hide()
	Jogo.hide()
	Game_Over.hide()
	
	#Adicionar botão dentro do vetor
	for button in $Control/Jogo/HBoxContainer.get_children():
		buttons.append(button)
	load_quiz()
	
	
#carregar as perguntas é
func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return
		
	descricao.text = current_quiz.question_info
	descricao_scr.text = current_quiz.question_script
	$Control/Jogo/ColorRect/Label.text = current_quiz.Nivel
	$Control/Jogo/ColorRect/Label2.text = current_quiz.Questao
	
	
	#Para Adicionar valores dentro do botão
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		#Pegar valores do botão
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
		
		
#Pegar valores do botão e adicionar logicar ao clocar
func _buttons_answer(button) -> void:
	if current_quiz.correct == button.text:
		button.modulate = color_right
		correct +=1
		$Correto.play()
	else:
		button.modulate = color_wrong
		$Incorreto.play()
	_next_question()
	
	print(button.text)
	
#Botão Iniciar
func _on_button_pressed():
	print("cliquei no botão")
	Tela_Pegar_Nome.show()
	pass # Replace with function body.

#Esse botão vai pegar nome do usuario
func _on_button_nome_pressed():
	var nome_text = Nome.text
	print("O nome inserido é: " + nome_text)
	mostrar_nome.text ="Olá " + nome_text +" Vamos entender como Funciona \ná dinamica do jogo"
	Tela_Informacao.show()
	pass # Replace with function body.


#Essa parte vai Iniciar o jogo
func _on_button_iniciar_jogo_pressed():
	print("Botão iniciar")
	Jogo.show()
	pass # Replace with function body.

#Passar para proxima quetaão
func _next_question() -> void:
	#desconectar todos os botão
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
		
	await  get_tree().create_timer(1).timeout
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	index += 1
	
	load_quiz()
	
func _game_over() -> void:
	Game_Over.show()
	descFinal.text = Nome.text + " Sua Pontuação foi de: "
	$Control/Game_Over/Score.text = str(correct, "/", quiz.theme.size())
	print("ACABOU SE TODAS AS PERGUNTAS")
