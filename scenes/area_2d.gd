extends Area2D

@export var dialogue_manager: Node
@export var npc_name: String = "路人NPC"
@export var lines: Array = ["你好！欢迎来到这里。", "第二句对话测试", "第三句，说完就关闭"]

var player_in_range: bool = false

func _on_body_entered(body):
	print("【进入】碰到物体：", body.name)
	if body.name == "Player":
		print("✅玩家进入对话范围")
		player_in_range = true
		var label = $"../Npc/Label"
		if label:
			label.visible = true

func _on_body_exited(body):
	print("【离开】碰到物体：", body.name)
	if body.name == "Player":
		print("❌玩家离开对话范围")
		player_in_range = false
		var label = $"../Npc/Label"
		if label:
			label.visible = false
		if dialogue_manager:
			dialogue_manager.close_dialogue()

func _process(delta):
	# 新增：如果对话已经打开，Area不再响应T
	if dialogue_manager and dialogue_manager.is_dialog_open:
		return
	
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		print("⌨按下ui_accept，尝试开启对话")
		if dialogue_manager:
			dialogue_manager.start_dialogue(npc_name, lines)
