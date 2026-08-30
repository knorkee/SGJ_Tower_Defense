extends Control
@onready var story_1: Sprite2D = $Story1
@onready var story_2: Sprite2D = $Story2
@onready var story_3: Sprite2D = $Story3
@onready var story_4: Sprite2D = $Story4
var counter: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("attack_button")):
		_changeStoryPic()

func _changeStoryPic() -> void:
	if(counter == 0):
		story_1.visible = false
		story_2.visible = true
		counter+=1
		return
	if(counter == 1):
		story_2.visible = false
		story_3.visible = true
		counter+=1
		return
	if(counter == 2):
		story_3.visible = false
		story_4.visible = true
		counter+=1
		return
	if(counter == 3):
		get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")
