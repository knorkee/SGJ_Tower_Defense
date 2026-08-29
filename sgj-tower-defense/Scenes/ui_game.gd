extends Control
@export var player : Node2D
@onready var texture_progress_bar: TextureProgressBar = $box/line_bottom/TextureProgressBar
@onready var wave_info: Label = $box/line_top/wave_info

# Called when the node enters the scene tree for the first time.
var health_comp
var wave
func _ready() -> void:
	wave = get_parent()
	wave_info.text = "Enemies left: " + str(wave.enemies)
	health_comp = player.get_node("healthComponent")
	texture_progress_bar.value = health_comp.Health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_info.text = "Enemies left: " + str(wave.enemies)
	if(health_comp != null):
		texture_progress_bar.value = health_comp.Health
	else:
		texture_progress_bar.value = 0
