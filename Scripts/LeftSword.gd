extends XRController3D

@export var ray_length = 1
@onready var sword_collision = $"Area3D/SwordCollision"
var sword_on = true

func _ready():
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0,0,1) 
	$"LineRenderer".material_override = mat

func _physics_process(delta: float):
	if sword_on == false:
		return
	var space_state = get_world_3d().direct_space_state
	
	var origin = global_position
	var dir = global_basis.z * -1
	var end = origin + (dir * ray_length)
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	query.collision_mask = 2
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	$"LineRenderer".points[0] = origin + dir * .1
	$"LineRenderer".points[1] = end
	
	if result:
		if sword_on:
			if result.collider.cube_color == "blue":
				$"AudioStreamPlayer3D".play()
				result.collider.queue_free()

func _on_button_pressed(name):
	if name == "ax_button":
		$"LineRenderer".visible = not $LineRenderer.visible
		sword_on = not sword_on
		sword_collision.disabled = not sword_on
		
