extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var particle_shoot: CPUParticles2D = $particle_shoot


@export var ProjectileScene: PackedScene
@export var AoE_Attack_Scene: PackedScene
@export var Health_Component: HealthComponent
var gameScene

var speed = 1

var projectile_cooldown : float = 0.3
var projectile_cd_counter : float = 0

var aoe_attack : Node2D
var aoe_preview_active : bool = false
var aoe_cooldown : float = 3
var aoe_cd_counter : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameScene = get_tree().get_first_node_in_group("gameScene")
	Health_Component.connect("health_below_zero", _on_player_death)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	cooldowns(delta)
	inputs()

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
	if(!gameScene.game_lost):
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
	
	if (aoe_cd_counter > 0):
		aoe_cd_counter -= delta


func inputs():
	if(gameScene.game_lost):
		return

	# auto attack
	if(Input.is_action_pressed("attack_button")):
		animated_sprite.play("player_attack")
		particle_shoot.look_at(get_global_mouse_position())
		particle_shoot.emitting = true
		attack()
	
	# AoE ability
	if (Input.is_action_just_pressed("ability_1")): # aoe pressed = preview
		
		if (aoe_cd_counter <= 0):
			
			aoe_preview_active = true
			aoe_attack = AoE_Attack_Scene.instantiate()
			aoe_attack.position = global_position
			aoe_attack.damage = 50 # set damage to be dealt
			get_tree().current_scene.add_child(aoe_attack)
		
	if (Input.is_action_just_released("ability_1")): # aoe released = activated
		
		if (aoe_preview_active):
			aoe_preview_active = false
			aoe_attack.activate_attack()
			#reset cooldown
			aoe_cd_counter = aoe_cooldown

func _on_player_death() -> void:
	queue_free()
