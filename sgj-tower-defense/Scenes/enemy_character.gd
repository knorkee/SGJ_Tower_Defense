extends CharacterBody2D
var SPEED: int = 1 * 10000
var target: Vector2 = Vector2.ZERO

#enemys laufen auf mutter schleim
#wenn player im radius auf player angreifen
#TODO Spawner, Angreiffen, angegriffen werden

func _physics_process(delta):
	var direction = target - position
	#var direction = Vector2.DOWN
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()
	
