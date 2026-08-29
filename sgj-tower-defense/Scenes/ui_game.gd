extends Control
@export var player : Node2D
@onready var texture_progress_bar: TextureProgressBar = $box/line_bottom/TextureProgressBar

# Called when the node enters the scene tree for the first time.
var health_comp
func _ready() -> void:
	health_comp = player.get_node("healthComponent")
	texture_progress_bar.value = health_comp.Health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health_comp != null):
		texture_progress_bar.value = health_comp.Health
	else:
		texture_progress_bar.value = 0
