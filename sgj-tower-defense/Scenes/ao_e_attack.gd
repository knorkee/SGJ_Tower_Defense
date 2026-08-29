extends Node2D

var preview_active : bool = true

var alive_counter : float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (preview_active):
		follow_mouse()
	
	if (!preview_active):
		attack_deployed(delta)

func follow_mouse():
	global_position = get_global_mouse_position()

func attack_deployed(delta:float):
	alive_counter -= delta
	
	if (alive_counter <= 0):
		queue_free()



func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func activate_attack() -> void:
	
	preview_active = false # switch modes
	
	# swap sprites
	get_node("preview").visible = false
	get_node("attack_area").visible = true
