extends CharacterBody3D

signal interact_object

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
	Input .mouse_mode = Input.MOUSE_MODE_CAPTURED


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
	
	

	# pick-up

	
var picked0bject
func pick_up(object):
	
	object.reparent(self)
	#object.global_position = %CarryObjectMarker.global_position
	
	await get_tree().create_timer(0.1).timeout
	picked0bject= object
	
	
func _process(delta):
	if hand.is_colliding():
		var collider = hand.get_collider()
		interact_object.emit(collider)
	else : interact_object.emit(null)
		
func _input(event):
	if event is InputEventMouseMotion:
		print("y : ",event.relative.x * CAMERA_SENS)
		print("x : ",event.relative.y * CAMERA_SENS)
		#Horizontal
		rotation.y -= event.relative.x * CAMERA_SENS
		#Vertical
		#rotation.x -= event.relative.y * CAMERA_SENS
	if event.is_action_pressed("interaction") and picked0bject:
		picked0bject.reparent(get_tree().current_scene)
		picked0bject=null 
		#si on appuie sur la touche interaction et qu'un objet est attrapé, on le remet dans la scene et on l'oublie de notre inventaire 

	if event.is_action_pressed("interaction") and picked0bject:
		picked0bject.reparent(get_tree().current_scene)
		picked0bject = null
