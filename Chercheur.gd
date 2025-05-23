extends Player
class_name Chercheur

var Points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func pick_up():
	if Input.is_action_just_pressed("pickup") and hand.is_colliding():
		if hand.get_collider().is_in_group("fuyard"):
			hand.get_collider().queue_free()
			Points += 1
