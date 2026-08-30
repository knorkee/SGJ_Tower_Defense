extends Area2D

@export var hit_indicatorScene: PackedScene

var expand_speed : float = 1
var damage : int = 1000

var max_size : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	expand(delta)

func damage_player():
	var player = get_tree().get_first_node_in_group("player")
	var player_health = player.get_node("HealthComponent")
	if (player_health == null):
		return
	
	var to_damage : int = player_health.hitpoints / 2
	
	var hit_indicator = hit_indicatorScene.instantiate()
	get_tree().current_scene.add_child(hit_indicator)
	hit_indicator.initialize(player.position, to_damage)
	player_health.receive_damage(to_damage)

func expand(delta : float):
	var collider = get_node("ColliderOfDoom")
	
	collider.scale *= (1 + delta) * expand_speed
	
	# end if max size reached
	if (collider.scale.length() > max_size):
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	
	# check if area is hitbox
	if (!area.is_in_group("hitbox")):
		return
	
	var parent_of_area = area.get_parent()
	
	#check if object is enemy
	if (!parent_of_area.is_in_group("enemy")):
		return
	
	var health = parent_of_area.get_node("HealthComponent")
	if (health != null):
		health.receive_damage(damage)
	
	#hit indicator
		var hit_indicator = hit_indicatorScene.instantiate()
		get_tree().current_scene.add_child(hit_indicator)
		hit_indicator.initialize(parent_of_area.global_position, damage)
