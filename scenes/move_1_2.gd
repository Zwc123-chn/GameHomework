extends Node2D

@export var point_a: Vector2 = Vector2.ZERO     
@export var point_b: Vector2 = Vector2(200, 0)  
@export var speed: float = 15            

var target: Vector2

func _ready() -> void:
	position = point_a
	target = point_b

func _physics_process(delta: float) -> void:
	position = position.move_toward(target, speed * delta)

	if position.distance_to(target) < 1.0:
		if target == point_b:
			target = point_a
		else:
			target = point_b
