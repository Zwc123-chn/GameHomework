extends Control
@export var cam:Camera2D
# UI放在【相机视口】里的相对位置，左上角(40,40)
@export var view_offset:Vector2 = Vector2(40,40)

func _process(delta):
	if cam == null:
		return
	# 获取相机在屏幕上的视口矩形
	var rect = cam.get_viewport_rect()
	# UI直接定位在视口内，屏幕坐标
	position = rect.position + view_offset
