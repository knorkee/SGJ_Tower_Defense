extends Area2D

var projectile_direction: Vector2

var speed = 5
var spawn_point

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var traveled : Vector2 = (global_position - spawn_point)
	var distance_traveled = traveled.length()
	if (distance_traveled > 1000): #delete if off screen
		queue_free()

func initialize(Direction: Vector2, Position: Vector2) -> void:
	projectile_direction = Direction
	position = Position
	spawn_point = Position

func _physics_process(delta: float) -> void:
	position += projectile_direction * speed * delta * 100

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("enemy")):
		
		#body.queue_free() # for bnow this just deletes the enemy -- add damage later
		var health = body.get_node("healthComponent")
		if (health != null):
			health.deal_damage(100)
		
		queue_free() # delete this projectile
