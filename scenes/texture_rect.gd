extends TextureRect

# 在检查器面板，把场景里对应的节点拖进这三个变量
@export var speaker_label: RichTextLabel
@export var text_label: RichTextLabel
@export var hint_label: Label

var dialogue_lines: Array[String] = []
var current_line: int = 0

func _ready():
	visible = false
	hint_label.visible = false

# 启动对话函数，NPC调用这个
func start_dialogue(npc_name: String, lines: Array[String]):
	# 防止重复打开对话
	if visible:
		return
	visible = true
	hint_label.visible = true
	current_line = 0
	speaker_label.text = npc_name
	dialogue_lines = lines
	show_line()

# 显示当前句子 + 打字机效果
func show_line():
	text_label.text = dialogue_lines[current_line]
	text_label.visible_characters = 0
	# 逐字显示
	await get_tree().create_timer(0.04).timeout
	text_label.visible_characters = text_label.text.length()

# 按键响应：空格继续对话；对话开启时屏蔽T键
func _input(event):
	if visible and event.is_action_just_pressed("ui_accept"):
		next_line()

# 切换下一句 / 关闭对话框
func next_line():
	current_line += 1
	if current_line >= dialogue_lines.size():
		# 对话结束，关闭对话框
		visible = false
		hint_label.visible = false
	else:
		show_line()
