extends RigidBody3D

@export var dir = Vector3(0, 0, 1)
@export var speed = 3
@export var cube_color = "blue"

func _ready():
	var cube = $"CSGBox3D"
	cube.material = StandardMaterial3D.new()
	if cube_color == "red":
		cube.material.albedo_color = Color(1,0,0)
	else:
		cube.material.albedo_color = Color(0,0,1)


func _physics_process(delta):
	global_position += dir * (speed * delta)
	if global_position.z > 1:
		queue_free()
