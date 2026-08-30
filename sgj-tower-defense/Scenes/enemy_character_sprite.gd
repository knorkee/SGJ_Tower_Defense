extends AnimatedSprite2D
# var SPEED: int = 1 * 10000
var target: Vector2 = Vector2.ZERO
var target_mom: Vector2 = Vector2.ZERO
var target_player: Vector2 = Vector2.ZERO
var is_following: bool = false
var enemy_attack_cooldown : float = 1
var enemy_attack_counter : float = 0
var mommy
var gameScene

@export var Health_Component: HealthComponent
@export var particle_enemy_deathScene: PackedScene
@export var hit_indicatorScene: PackedScene


func _ready():
	mommy = get_tree().get_first_node_in_group("mommy")
	gameScene = get_tree().get_first_node_in_group("gameScene")
	Health_Component.connect("health_below_zero", _on_enemy_death)

func _physics_process(delta):
	if(mommy != null):
		if(!is_following):
			var vector_to_mommy = mommy.position - global_position
			var distance_to_mommy = vector_to_mommy.length()
			if(distance_to_mommy < 20):
				print("bin bei mama")
				cooldowns(delta)
				_attack(mommy)
			else:
				_move(target)
		else:
			var player = get_tree().get_first_node_in_group("player")
			var vector_to_player = player.position - global_position
			var distance_to_player = vector_to_player.length()
			if(distance_to_player < 20):
				cooldowns(delta)
				_attack(player)
			else:
				_move(player.position)
	else:
		gameScene.game_lost = true
	#if(!is_following):
		#var direction = target - global_position
		# var direction = Vector2.DOWN
		#direction = direction.normalized()
		# global_position = direction * SPEED * delta
		#position = position + direction
func _move(target: Vector2) -> void:
	var direction = target - global_position
	direction = direction.normalized()
	position = position + direction
	
func _attack(player: Node2D) -> void:
	if (enemy_attack_counter > 0):
		return
	var health_comp = player.get_node("HealthComponent")
	health_comp.receive_damage(20)
	print("attack")
	enemy_attack_counter = enemy_attack_cooldown
	
	#hit indicator
	var hit_indicator = hit_indicatorScene.instantiate()
	get_tree().current_scene.add_child(hit_indicator)
	hit_indicator.initialize(global_position, 20)
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		is_following = true
		target_player = body.position
		var direction = body.position - global_position
		direction = direction.normalized()
		# global_position = direction * SPEED * delta
		global_position = global_position + direction
func cooldowns(delta: float):
	if(enemy_attack_counter > 0):
		enemy_attack_counter -= delta

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		is_following = false
		target_mom = target 

func _on_enemy_death() -> void:
	gameScene.enemies -= 1
	
	#spawn particles
	var particle = particle_enemy_deathScene.instantiate()
	get_tree().current_scene.add_child(particle)
	particle.initialize(global_position)
	
	
	queue_free()
