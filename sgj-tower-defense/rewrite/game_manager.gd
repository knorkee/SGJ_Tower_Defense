extends Node

@export var main_menu_scene: PackedScene
@export var start_scene: PackedScene
var current_scene: Node = null

func _ready() -> void:
	pass

func _on_exit_game() -> void:
	get_tree().quit()

func _change_scene() -> void:
	pass
