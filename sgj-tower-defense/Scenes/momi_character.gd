extends CharacterBody2D

@export var Health_Component: HealthComponent

func _ready() -> void:
	Health_Component.connect("health_below_zero", _on_momi_death)

func _on_momi_death() -> void:
	queue_free()
