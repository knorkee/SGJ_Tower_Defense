extends Node2D
@onready var enemy_spawner_right: Node2D = $enemy_spawner_right
@onready var enemy_spawner_left: Node2D = $enemy_spawner_left
@onready var enemy_spawner_top: Node2D = $enemy_spawner_top
@onready var next_wave_button: TextureButton = $NextWaveButton
@onready var game_over_screen: Node2D = $GameOverScreen

@onready var dmg: Label = $ui_game/box/line_top/stats_box/dmg_number
@onready var _const: Label = $ui_game/box/line_top/stats_box/const_number
@onready var floppynes: Label = $ui_game/box/line_top/stats_box/floppynes_number

@export var hit_indicator: PackedScene

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
	if(enemies == 0 && enemyCounter == 0 && game_won == false):
		game_won = true
		
		#fake upgrade
		var mult_indicator1 = hit_indicator.instantiate()
		var mult_indicator2 = hit_indicator.instantiate()
		var mult_indicator3 = hit_indicator.instantiate()
		
		get_tree().current_scene.add_child(mult_indicator1)
		get_tree().current_scene.add_child(mult_indicator2)
		get_tree().current_scene.add_child(mult_indicator3)
		
		var tween = create_tween()
		tween.tween_property(dmg, "scale", Vector2(1.5,1.5), 0.4)
		tween.parallel().tween_property(dmg, "modulate", Color.RED,0.2)
		tween.parallel().tween_property(_const, "scale", Vector2(1.5,1.5), 0.4)
		tween.parallel().tween_property(_const, "modulate", Color.RED,0.2)
		tween.parallel().tween_property(floppynes, "scale", Vector2(1.5,1.5), 0.4)
		tween.parallel().tween_property(floppynes, "modulate", Color.RED,0.2)
		
		mult_indicator1.initialize_text_moving_down(dmg.global_position,"x1",Color.RED)
		mult_indicator2.initialize_text_moving_down(_const.global_position,"x1",Color.RED)
		mult_indicator3.initialize_text_moving_down(floppynes.global_position,"x1",Color.RED)
		
		
		tween.tween_property(dmg, "scale", Vector2(1.0,1.0), 0.4)
		tween.parallel().tween_property(dmg, "modulate", Color.WHITE, 0.2)
		tween.parallel().tween_property(_const, "scale", Vector2(1.0,1.0), 0.4)
		tween.parallel().tween_property(_const, "modulate", Color.WHITE, 0.2)
		tween.parallel().tween_property(floppynes, "scale", Vector2(1.0,1.0), 0.4)
		tween.parallel().tween_property(floppynes, "modulate", Color.WHITE, 0.2)
		if(await tween.finished):
			tween.kill()
			
			
			
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
