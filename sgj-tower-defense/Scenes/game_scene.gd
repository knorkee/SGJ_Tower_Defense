extends Node2D
@onready var enemy_spawner_right: Node2D = $enemy_spawner_right
@onready var enemy_spawner_left: Node2D = $enemy_spawner_left
@onready var enemy_spawner_top: Node2D = $enemy_spawner_top
var enemyCounter: int
var waveCounter: int = 1
var spawnerCounter: int = 0
var enemies: int =  0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyCounter = waveCounter * 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _generate_random_number() -> int:
	var rng = RandomNumberGenerator.new()
	var number = rng.randi_range(0,2)
	return number
func _on_timer_timeout() -> void:
	if(enemyCounter > 0):
		enemies+=1
		enemyCounter = enemyCounter - 1
		spawnerCounter = _generate_random_number()
		if(spawnerCounter == 0):
			enemy_spawner_left._spawnEnemy()
			print("spawn left")
		if(spawnerCounter == 1):
			enemy_spawner_top._spawnEnemy()
			print("spawn top")
		if(spawnerCounter == 2):
			enemy_spawner_right._spawnEnemy()
			print("spawn right")
		print(enemyCounter)
