extends Node2D

@export var text_display: RichTextLabel
@export var name_display: RichTextLabel
@export var hint_label: Label

# 加上export，让外面Area可以读到这个变量
@export var is_dialog_open: bool = false
var current_lines: Array
var current_index: int = 0
var speaker_name: String = ""

func start_dialogue(npc_name: String, lines: Array):
	if is_dialog_open:
		next_line()
		return
	
	print("✅打开对话框")
	is_dialog_open = true
	speaker_name = npc_name
	current_lines = lines
	current_index = 0
	show_line()
	$CanvasLayer/TextureRect.visible = true

func show_line():
	name_display.text = speaker_name
	text_display.text = current_lines[current_index]
	hint_label.text = "按T继续"
	# 新增这两行打印，调试用
	print("NPC名字：", speaker_name)
	print("当前台词：", current_lines[current_index])


func next_line():
	current_index += 1
	if current_index >= current_lines.size():
		close_dialogue()
	else:
		show_line()

func close_dialogue():
	print("❌关闭对话框")
	is_dialog_open = false
	$CanvasLayer/TextureRect.visible = false
