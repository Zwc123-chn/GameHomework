extends Label

# 需要外部拖拽赋值
@export var talk_trigger: Area2D
@export var dialog_panel: Panel

var player_in_range:bool = false
var is_talking:bool = false

func _ready():

	visible = false

	# 监听Area2D的进入/离开信号
	talk_trigger.body_entered.connect(_on_body_entered)
	talk_trigger.body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		visible = true
		refresh_text()


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		visible = false
		# 离开区域自动关闭对话，重置状态
		if is_talking:
			is_talking = false
			dialog_panel.visible = false


func refresh_text():
	if is_talking:
		text = "按 R 退出"
	else:
		text = "按 T 对话"


func _process(delta):
	if not player_in_range:
		return
	
	# T开启对话
	if Input.is_action_just_pressed("ui_accept") and !is_talking:
		is_talking = true
		dialog_panel.visible = true
		refresh_text()
	
	# R关闭对话
	if Input.is_action_just_pressed("ui_cancel") and is_talking:
		is_talking = false
		dialog_panel.visible = false
		refresh_text()
