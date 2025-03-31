extends CharacterBody3D

var selected  = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var outlineWidth= 0.05
var player
var object
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grab") and selected:
		player.pick_up_object(self)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
