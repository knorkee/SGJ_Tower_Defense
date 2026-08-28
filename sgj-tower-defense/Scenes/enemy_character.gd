extends CharacterBody2D
@export var player : CharacterBody2D
var SPEED: int = 1 * 10000

#enemys laufen auf mutter schleim
#wenn player im radius auf player angreifen
#TODO Spawner, Angreiffen, angegriffen werden
func _physics_process(delta):
	var direction = player.position - position
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()
