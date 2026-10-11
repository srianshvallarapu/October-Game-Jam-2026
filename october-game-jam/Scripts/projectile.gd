extends Area2D

@export var speed: float = 600.0

func _process(delta: float) -> void:
	position += transform.x * speed * delta
