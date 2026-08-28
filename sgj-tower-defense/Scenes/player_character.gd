extends CharacterBody2D

var speed = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	
	# get mvoement direction here
	if(Input.is_action_pressed("move_up")):
		direction.y = -1
	if(Input.is_action_pressed("move_down")):
		direction.y = 1
	if(Input.is_action_pressed("move_right")):
		direction.x = 1
	if(Input.is_action_pressed("move_left")):
		direction.x = -1
		
	
	velocity = direction * speed * delta * 10000
	move_and_slide()
