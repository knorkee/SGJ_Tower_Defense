extends Sprite2D
# var SPEED: int = 1 * 10000
var target: Vector2 = Vector2.ZERO
var target_mom: Vector2 = Vector2.ZERO
var target_player: Vector2 = Vector2.ZERO
var is_following: bool = false

#enemys laufen auf mutter schleim
#wenn player im radius auf player angreifen
#TODO Spawner, Angreiffen, angegriffen werden

func _physics_process(delta):
	if(!is_following):
		_move(target)
	else:
		var player = get_tree().get_first_node_in_group("player")
		_move(player.position)
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
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		is_following = true
		target_player = body.position
		var direction = body.position - global_position
		direction = direction.normalized()
		# global_position = direction * SPEED * delta
		global_position = global_position + direction


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		is_following = false
		target_mom = target 
