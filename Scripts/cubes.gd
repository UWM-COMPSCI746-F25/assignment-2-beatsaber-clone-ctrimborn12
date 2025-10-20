extends Node3D

@onready var cube = load("res://Scenes/FlyingCube.tscn")
@onready var scene_root = get_tree().current_scene
@export var dist = 12
@export var low_time = 0.5
@export var high_time = 2
@onready var timer = $"Timer"

func _ready(): 
	timer.one_shot = false
	timer.wait_time = randf_range(low_time, high_time)
	timer.start()
	
		
func spawn():
	var instance = cube.instantiate()
	var x = randf_range(-1.5,1.5)
	var y = randf_range(0.5, 2.0)
	instance.position.x = x
	instance.position.y = y
	instance.position.z = -dist
	instance.cube_color = ["red", "blue"][randi() % 2]
	scene_root.add_child(instance)
	

func _on_timer_timeout() -> void:
	spawn() 
