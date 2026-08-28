extends Area2D

var projectile_direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize(direction: Vector2) -> void:
	projectile_direction = direction

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("enemy")):
		body.queue_free() # for bnow this just deletes the enemy -- add damage later
