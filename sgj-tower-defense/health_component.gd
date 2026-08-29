extends Node2D
signal enemy_death
@export var Health : int = 100
@export var enemy_death_particle: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deal_damage(damage: int) -> void:
	Health -= damage
	if (Health <= 0):
		var gameScene = get_tree().get_first_node_in_group("gameScene")
		gameScene.enemies -=1
		get_parent().queue_free()
		
