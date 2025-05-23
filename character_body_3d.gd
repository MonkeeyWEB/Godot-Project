extends CharacterBody3D
class_name Player





@onready var audio_stream_player_3d: AudioStreamPlayer3D = $CSGBox3D/AudioStreamPlayer3D
@onready var bruits_pas: AudioStreamPlayer3D = $"bruits pas"
@onready var camera_3d: Camera3D = $Camera3D
@onready var hand: RayCast3D = $Camera3D/hand


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const CAMERA_SENS = 0.005

func _ready() -> void:
	# Initialise le mode de camera à la première personne
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("gauche", "droite", "avancer", "reculer")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction :
		if not bruits_pas.playing:
			bruits_pas.play()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
	

		
func _input(event):
	if event is InputEventMouseMotion:
		print("y : ",event.relative.x * CAMERA_SENS)
		print("x : ",event.relative.y * CAMERA_SENS)
		#Horizontal
		rotation.y -= event.relative.x * CAMERA_SENS
		#Vertical
		

	
