extends Node3D
var fuyard_scene = preload("res://fuyard.tscn")
var chercheur_scene = preload("res://player.tscn")
# Called when the node enters the scene tree for the first time.
@onready var spawn: Node3D = $Spawn

func _ready() -> void:
	var random = randi_range(1,2)
	
	if random == 1:
		var fuyard = fuyard_scene.instantiate()
		add_child(fuyard)
		fuyard.global_position = spawn.global_position
	else:
		var chercheur = chercheur_scene.instantiate()
		add_child(chercheur)
		chercheur.global_position = spawn.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
