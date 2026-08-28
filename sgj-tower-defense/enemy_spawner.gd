extends Node2D
@export var enemy_prefab : PackedScene
@export var Target : Node2D

func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	add_child(enemy)
	enemy.target = Target.global_position
	  
