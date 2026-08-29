class_name HealthComponent extends Node

signal health_below_zero

@export var hitpoints : int = 100

func receive_damage(damage: int) -> void:
	hitpoints -= damage
	if hitpoints <= 0:
		health_below_zero.emit()
