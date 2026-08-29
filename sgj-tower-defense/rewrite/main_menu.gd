extends Control

signal start_game
signal show_credits
signal exit_game

@onready var start: Button = $VBoxContainer/VBoxContainer/start
@onready var credit: Button = $VBoxContainer/VBoxContainer/credit
@onready var exit: Button = $VBoxContainer/VBoxContainer/exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start.connect("pressed", _on_start_pressed)
	credit.connect("pressed", _on_credit_pressed)
	exit.connect("pressed", _on_exit_pressed)


func _on_start_pressed() -> void:
	start_game.emit()

func _on_credit_pressed() -> void:
	show_credits.emit()

func _on_exit_pressed() -> void:
	exit_game.emit()
