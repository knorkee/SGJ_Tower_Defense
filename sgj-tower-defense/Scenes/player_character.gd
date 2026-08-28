extends CharacterBody2D

@export var ProjectileScene: PackedScene

var speed = 2

var projectile_cooldown : float = 0.3
var projectile_cd_counter : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldowns(delta)
	
	if(Input.is_action_pressed("attack_button")):
		attack()

func attack() -> void:
	if (projectile_cd_counter > 0):
		return
	
	var projectile = ProjectileScene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()
	projectile.initialize(mouse_dir, global_position)
	
	#reset cooldown
	projectile_cd_counter = projectile_cooldown


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


func cooldowns(delta: float):
	if(projectile_cd_counter > 0):
		projectile_cd_counter -= delta
