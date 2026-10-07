extends Control
@export var cam:Camera2D
@export var view_offset:Vector2 = Vector2(40,40)

func _process(delta):
	if cam == null:
		return
	var rect = cam.get_viewport_rect()
	position = rect.position + view_offset
