extends Node2D
@onready var enemy_spawner_right: Node2D = $enemy_spawner_right
@onready var enemy_spawner_left: Node2D = $enemy_spawner_left
@onready var enemy_spawner_top: Node2D = $enemy_spawner_top
@onready var next_wave_button: TextureButton = $NextWaveButton
@onready var game_over_screen: Node2D = $GameOverScreen


var enemyCounter: int
var waveCounter: int = 1
var spawnerCounter: int = 0
var enemies: int =  0
var game_lost: bool = false
var game_won: bool = false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	_prepareEnemies()
	next_wave_button.visible = false
func _prepareEnemies() -> void:
	enemyCounter = waveCounter * 10	
	
func _process(delta: float) -> void:
	if(enemies == 0 && enemyCounter == 0):
		game_won = true
	if(game_lost):
		game_over_screen.show()
	if(game_won):
		next_wave_button.visible = true
		#_spawnWaveButton()
		#_start_next_wave()
#func _spawnWaveButton() -> void:
#	var button = NextWaveButtonPrefab.instantiate()
#button.position = Vector2(320,170)
#	add_child(button)
func _start_next_wave() -> void:
	waveCounter +=1
	_prepareEnemies()
	game_won = false
	
func sleep(seconds: float)->void:
	await get_tree().create_timer(seconds).timeout
func _generate_random_number() -> int:
	var rng = RandomNumberGenerator.new()
	var number = rng.randi_range(0,2)
	return number
func _on_timer_timeout() -> void:
	if(!game_lost):
		if(enemyCounter > 0):
			enemies+=1
			enemyCounter = enemyCounter - 1
			spawnerCounter = _generate_random_number()
			if(spawnerCounter == 0):
				enemy_spawner_left._spawnEnemy()
			if(spawnerCounter == 1):
				enemy_spawner_top._spawnEnemy()
			if(spawnerCounter == 2):
				enemy_spawner_right._spawnEnemy()


func _on_next_wave_button_pressed() -> void:
	_start_next_wave()
	next_wave_button.visible = false
