extends Node2D

var preview_active : bool = true

var alive_counter : float = 0.2

var damage : int

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

var objects_in_area = []

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.is_in_group("hitbox")):
		objects_in_area.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.is_in_group("hitbox")):
		objects_in_area.erase(area)

func attack_all_in_area():
	for object in objects_in_area:
		
		var hitbox : Area2D = object
		var parent = hitbox.get_parent()
		
		if (!parent.is_in_group("enemy")):
			continue
		
		var health_cp = parent.get_node("healthComponent")
		health_cp.deal_damage(damage)


func activate_attack() -> void:
	
	preview_active = false # switch modes
	
	# swap sprites
	get_node("preview").visible = false
	get_node("attack_area").visible = true
	
	attack_all_in_area()
