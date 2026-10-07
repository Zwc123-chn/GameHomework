extends VBoxContainer
# 拖入刚才做好的单行预制体LogRow.tscn
@export var row_prefab:PackedScene
# 父面板，用来控制显示隐藏（就是上面的Panel）
@export var ui_panel:Control


# 【调用这个函数，触发新增一行】
# icon：图片资源；msg：文字内容
func add_log_line(icon:Texture2D, msg:String):
	# 如果是第一次添加，自动显示UI面板
	if ui_panel.visible == false:
		ui_panel.visible = true
	
	# 实例新的一行
	var new_row = row_prefab.instantiate()
	# 设置这一行的图标和文字
	new_row.icon_texture = icon
	new_row.message_text = msg
	
	# 添加到列表容器，自动排在最下面
	add_child(new_row)
	
	# 可选：限制最多行数，避免无限堆积
	if get_child_count() > 6:
		get_child(0).queue_free()
