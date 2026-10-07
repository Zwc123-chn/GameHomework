extends Area2D

@export var bullet_speed: float = 100
@export var damage: float = 10.0
var dir: Vector2

func _physics_process(delta):
	position += dir * bullet_speed * delta
	if global_position.x < -100 or global_position.x > get_viewport_rect().size.x + 100:
		queue_free()

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		print("玩家中弹！造成 %s 点伤害" % damage)
		body.take_damage(damage)
	queue_free()

func _ready():
	body_entered.connect(_on_body_entered)
