extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int = 1
var correct: int

@onready var texture_rect: TextureRect = $Control/VBoxContainer/ColorRect/Panel/TextureRect
@onready var Button_Iniciar: Button = $Control/VBoxContainer/ColorRect/VBoxContainer/ColorRect/Button

@onready var Tela_Pegar_Nome: ColorRect = $Control/ColorRect
@onready var Nome: LineEdit = $Control/ColorRect/LineEdit

@onready var Tela_Informacao: ColorRect = $Control/Tela_Informacao
@onready var mostrar_nome: Label = $Control/Tela_Informacao/Label
@onready var Iniciar_Jogo: Button = $Control/Tela_Informacao/ColorRect3/Button

@onready var Jogo: ColorRect = $Control/Jogo
@onready var descricao: Label = $Control/Jogo/Label
@onready var descricao_scr: Label = $Control/Jogo/ColorRect2/Label

func _ready():
	var img_texture = preload("res://imgs/Nilsin.png")
	texture_rect.texture = img_texture
	Tela_Pegar_Nome.hide()
	Tela_Informacao.hide()
	Jogo.hide()
	
	#Adicionar botão dentro do vetor
	for button in $Control/Jogo/VBoxContainer.get_children():
		buttons.append(button)
	load_quiz()
	
	
#carregar as perguntas
func load_quiz() -> void:
	descricao.text = quiz.theme[index].question_info
	descricao_scr.text = quiz.theme[index].question_script
	
	#Para Adicionar valores dentro do botão
	var options = quiz.theme[index].options
	for i in buttons.size():
		buttons[i].text = options[i]
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
