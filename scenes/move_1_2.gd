extends Node2D

@export var point_a: Vector2 = Vector2.ZERO      # 起点（在检查器中设置）
@export var point_b: Vector2 = Vector2(200, 0)   # 终点（在检查器中设置）
@export var speed: float = 15               # 移动速度（像素/秒）

var target: Vector2

func _ready() -> void:
	# 初始位置设为 point_a，目标为 point_b
	position = point_a
	target = point_b

func _physics_process(delta: float) -> void:
	# 朝目标点匀速移动
	position = position.move_toward(target, speed * delta)

	# 到达目标点后切换目标
	if position.distance_to(target) < 1.0:
		if target == point_b:
			target = point_a
		else:
			target = point_b
