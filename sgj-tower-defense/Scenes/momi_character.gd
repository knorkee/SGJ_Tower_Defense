extends CharacterBody2D

const DEATHSOUND = preload("res://Assets/music/deathsound.wav")

@export var Health_Component: HealthComponent
@export var particle_mom_deathScene: PackedScene
@onready var sfx: AudioStreamPlayer = $SFX
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	Health_Component.connect("health_below_zero", _on_momi_death)
	sfx.stream = DEATHSOUND
	sfx.pitch_scale = 0.5

func _on_momi_death() -> void:
	#spawn particles
	if not visible:
		return
	visible = false
	collision_shape_2d.disabled = true
	var particle = particle_mom_deathScene.instantiate()
	get_tree().current_scene.add_child(particle)
	particle.initialize(global_position)
	sfx.play()
	await sfx.finished
	queue_free()
