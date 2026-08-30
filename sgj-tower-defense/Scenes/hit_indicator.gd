extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func initialize(Position: Vector2) -> void:
	position = Position
	var target = Vector2(Position.x,Position.y - 30)
	
	var tween = create_tween()
	tween.tween_property(get_node("."), "position", target, 1.0 )
	print("running")
	if(await tween.finished):
		tween.kill()
	queue_free()
	
	
	
	
	
