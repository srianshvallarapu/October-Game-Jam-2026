extends Area2D

#TO HAI NGUYEN IF U READ: DO NOT TOUCH THIS STUFF IT IS IMPORTANTE
@export var projectile_scene: PackedScene = preload("res://Scenes/projectile.tscn")

# TO HAI NGUYEN: YOU CAN CHANGE THESE THREE FOR LIKE A FEEL OF THE GAME. THE NAMES ARE SELF EXPLANITORY
@export var orbit_speed: float = 1.5
@export var orbit_radius: float = 200.0
@export var fire_rate_cooldown: float = 0.25

@onready var orbit_center: Node2D = $".."
@onready var muzzle: Marker2D = get_node("Front")


var current_angle: float = 0.0
var can_shoot: bool = true

func _process(delta: float) -> void:
	if not orbit_center:
		return
		
	
	current_angle += orbit_speed * delta
	
	var offset = Vector2(cos(current_angle), sin(current_angle)) * orbit_radius
	global_position = orbit_center.global_position + offset
	
	look_at(get_global_mouse_position())
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		shoot()

func shoot() -> void:
	if projectile_scene and muzzle:
		can_shoot = false
		
		var projectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
		
		projectile.global_position = muzzle.global_position
		projectile.global_rotation = muzzle.global_rotation
		
		await get_tree().create_timer(fire_rate_cooldown).timeout
		can_shoot = true
