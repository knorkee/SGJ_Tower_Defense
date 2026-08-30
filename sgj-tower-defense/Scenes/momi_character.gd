extends CharacterBody2D

@export var Health_Component: HealthComponent
@export var particle_mom_deathScene: PackedScene
@onready var audio_stream_player_death: AudioStreamPlayer = $"../AudioStreamPlayerDeath"

func _ready() -> void:
	Health_Component.connect("health_below_zero", _on_momi_death)

func _on_momi_death() -> void:
	
	#spawn particles
	var particle = particle_mom_deathScene.instantiate()
	get_tree().current_scene.add_child(particle)
	particle.initialize(global_position)
	audio_stream_player_death.play()
	
	queue_free()
