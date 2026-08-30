extends CharacterBody2D

const DEATHSOUND = preload("res://Assets/music/deathsound.wav")
const SHOOTSOUND = preload("res://Assets/music/shootsound.wav")
const DMG = preload("res://Assets/music/dmg.wav")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $SFX
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var ProjectileScene: PackedScene
@export var AoE_Attack_Scene: PackedScene
@export var Health_Component: HealthComponent
@export var particle_shootScene: PackedScene

var gameScene

var speed = 1

var projectile_cooldown : float = 0.3
var projectile_cd_counter : float = 0

# aoe stuff
var aoe_attack : Node2D
var aoe_preview_active : bool = false
var aoe_cooldown : float = 3
var aoe_cd_counter : float = 0

#kamiGatze Stuff
var kamiGatze_ready : bool = true
@export var KamiGatzeScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameScene = get_tree().get_first_node_in_group("gameScene")
	Health_Component.connect("health_below_zero", _on_player_death)
	Health_Component.connect("received_damage", _on_receive_damage)
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
	
	
	var particle = particle_shootScene.instantiate()
	get_tree().current_scene.add_child(particle)
	particle.initialize(get_global_mouse_position(), global_position)
	sfx.stream = SHOOTSOUND
	sfx.pitch_scale = 1.0
	sfx.play()
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
		attack()
	
	# AoE ability
	if (Input.is_action_just_pressed("ability_1")): # aoe pressed = preview
		
		if (aoe_cd_counter <= 0):
			aoe_preview_active = true
			aoe_attack = AoE_Attack_Scene.instantiate()
			aoe_attack.damage = 100 # set damage to be dealt
			get_tree().current_scene.add_child(aoe_attack)
	if (Input.is_action_just_released("ability_1")): # aoe released = activated
		
		if (aoe_preview_active):
			aoe_preview_active = false
			aoe_attack.activate_attack()
			#reset cooldown
			aoe_cd_counter = aoe_cooldown
	
	# Kami Gatze Ability
	if (Input.is_action_just_pressed("ability_2") && kamiGatze_ready):
		var kamiGatze = KamiGatzeScene.instantiate()
		kamiGatze.position = global_position
		get_tree().current_scene.add_child(kamiGatze)
		kamiGatze_ready = false

func _on_player_death() -> void:
	if not visible:
		return
	visible = false
	collision_shape_2d.disabled = true
	set_process(false)
	sfx.stream = DEATHSOUND
	sfx.pitch_scale = 0.5
	sfx.play()
	await sfx.finished
	queue_free()

func _on_receive_damage() -> void:
	sfx.stream = DMG
	sfx.pitch_scale = 1.8
	sfx.play()
