extends Node2D

@export var Health : int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deal_damage(damage: int) -> void:
	Health -= damage
	if (Health <= 0):
		get_parent().queue_free()
