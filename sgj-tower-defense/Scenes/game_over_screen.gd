extends Node2D
var gameScene
@onready var kills: Label = $VBoxContainer/HBoxContainer2/kills
@onready var time: Label = $VBoxContainer/HBoxContainer3/time
@onready var waves: Label = $VBoxContainer/HBoxContainer4/waves

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameScene = get_tree().get_first_node_in_group("gameScene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!gameScene.game_lost):
		updateNumbers()
	pass



func updateNumbers() -> void:
	kills.text = "Kills: " + str(gameScene.killCounter)
	time.text = "Time: " + _deltaTimeToMinSecString(gameScene.timePassed)
	waves.text = "Waves survived: " + str(gameScene.waveCounter - 1)
	
func _deltaTimeToMinSecString(deltaTime) -> String:
	var minutes = deltaTime / 60
	var seconds = fmod(deltaTime, 60)
	return "%02d:%02d" % [minutes, seconds]
	
func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
