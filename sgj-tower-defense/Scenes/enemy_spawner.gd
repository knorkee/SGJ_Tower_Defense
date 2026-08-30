extends Node2D
@export var game_scene: Node2D
@export var enemy_prefab : PackedScene
@export var Target : Node2D
@export var Player : Node2D
@export var min_x: int
@export var max_x: int
@export var min_y: int
@export var max_y: int
func _generate_random_pos(min_x,max_x,min_y,max_y):
	var rng = RandomNumberGenerator.new()
	var x = rng.randi_range(min_x, max_x)
	var y = rng.randi_range(min_y, max_y)
	return Vector2(x,y)
func _spawnEnemy() -> void:
		var enemy = enemy_prefab.instantiate()
		var healthcomp = enemy.get_node("HealthComponent")
		healthcomp.hitpoints = healthcomp.hitpoints * game_scene.waveCounter
		add_child(enemy)
		enemy.target = Target.global_position
		enemy.position = _generate_random_pos(min_x,max_x,min_y,max_y)
		
'func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	add_child(enemy)
	enemy.target = Target.global_position
	enemy.position = _generate_random_pos(min_x,max_x,min_y,max_y)
'
