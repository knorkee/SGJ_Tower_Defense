extends CharacterBody2D
var SPEED: int = 1 * 10000
var target: Vector2 = Vector2.ZERO

#enemys laufen auf mutter schleim
#wenn player im radius auf player angreifen
#TODO Spawner, Angreiffen, angegriffen werden

func _physics_process(delta):
	var direction = target - global_position
	# var direction = Vector2.DOWN
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("detected")
	if(body.is_in_group("player_character")):
		print("detected")
		var direction = body.position - global_position
		direction = direction.normalized()
		# global_position = direction * SPEED * delta
		position = position + direction


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
