extends Node

@onready var texture_rect: TextureRect = $Control/VBoxContainer/ColorRect/Panel/TextureRect
@onready var Button_Iniciar: Button = $Control/VBoxContainer/ColorRect/VBoxContainer/ColorRect/Button

@onready var Tela_Pegar_Nome: ColorRect = $Control/ColorRect
@onready var Nome: LineEdit = $Control/ColorRect/LineEdit

@onready var Tela_Informacao: ColorRect = $Control/Tela_Informacao
@onready var mostrar_nome: Label = $Control/Tela_Informacao/Label

func _ready():
	var img_texture = preload("res://imgs/Nilsin.png")
	texture_rect.texture = img_texture
	Tela_Pegar_Nome.hide()
	Tela_Informacao.hide()

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

