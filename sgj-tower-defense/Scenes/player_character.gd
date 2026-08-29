extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var ProjectileScene: PackedScene

var speed = 1

var projectile_cooldown : float = 0.3
var projectile_cd_counter : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldowns(delta)
	
	if(Input.is_action_pressed("attack_button")):
		animated_sprite.play("player_attack")
		attack()
	
	if (Input.is_action_pressed("EndGame")):
		get_tree().quit()

func attack() -> void: #can u pls make it so attack can only happen every 20 frames, so it matches the animation?
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
		animated_sprite.play("player_walk")
		direction.y = -1
	if(Input.is_action_pressed("move_down")):
		animated_sprite.play("player_walk")
		direction.y = 1
	if(Input.is_action_pressed("move_right")):
		animated_sprite.play("player_walk")
		direction.x = 1
	if(Input.is_action_pressed("move_left")):
		animated_sprite.play("player_walk")
		direction.x = -1
		
	
	velocity = direction * speed * delta * 10000
	move_and_slide()


func cooldowns(delta: float):
	if(projectile_cd_counter > 0):
		projectile_cd_counter -= delta
