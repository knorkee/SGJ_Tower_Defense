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


func _on_area_entered(area: Area2D) -> void:
	
	if (!area.is_in_group("hitbox")):
		return
		
	var parent_of_area = area.get_parent()
	
	if (parent_of_area.is_in_group("enemy")):
		
		var health = parent_of_area.get_node("HealthComponent")
		if (health != null):
			health.receive_damage(100)
		
		queue_free()
