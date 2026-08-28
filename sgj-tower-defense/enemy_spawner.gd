extends Node2D
@export var enemy_prefab : PackedScene
var Target : Node2D

func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	add_child(enemy)
	enemy.target = Target.global_position
	  
