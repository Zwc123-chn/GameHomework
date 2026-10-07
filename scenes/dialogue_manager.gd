extends Node2D

@export var text_display: RichTextLabel
@export var name_display: RichTextLabel
@export var hint_label: Label

@export var is_dialog_open: bool = false
var current_lines: Array
var current_index: int = 0
var speaker_name: String = ""
var just_opened: bool = false

func start_dialogue(npc_name: String, lines: Array):
	if is_dialog_open:
		next_line()
		return
	

	is_dialog_open = true
	just_opened = true
	speaker_name = npc_name
	current_lines = lines
	current_index = 0
	$CanvasLayer/TextureRect.visible = true
	call_deferred("show_line")

func show_line():
	name_display.text = speaker_name
	text_display.text = current_lines[current_index]
	if current_index >= current_lines.size() - 1:
		hint_label.text = "press Esc to exit"
	else:
		hint_label.text = "press Enter to continue"


func next_line():
	current_index += 1

	if current_index >= current_lines.size():
		close_dialogue()
	else:
		show_line()

func close_dialogue():

	is_dialog_open = false
	$CanvasLayer/TextureRect.visible = false

func _process(delta):
	if is_dialog_open:
		if Input.is_action_just_pressed("ui_accept"):
			if just_opened:
				
				just_opened = false
			else:
			
				next_line()
		if Input.is_action_just_pressed("ui_cancel"):
			
			close_dialogue()
