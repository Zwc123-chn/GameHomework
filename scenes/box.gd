extends Area2D

@export var correct_password: String = "1234"
@onready var texture_rect: TextureRect = $TextureRect
@onready var line_edit: LineEdit = $TextureRect/LineEdit
@onready var error_label: Label = $TextureRect/Label
var is_unlocked: bool = false

func _ready():
	texture_rect.visible = false
	error_label.text = "Enter 4 numbers"  # 初始提示
	body_entered.connect(_on_player_enter)
	line_edit.text_submitted.connect(_on_confirm)

func _on_player_enter(body: Node2D):
	if is_unlocked:
		return
	if body.is_in_group("Player"):
		texture_rect.visible = true
		line_edit.text = ""
		error_label.text = "Enter 4 numbers"  # 弹出时也显示提示
		line_edit.grab_focus()

func _on_confirm(text: String):
	if line_edit.text == correct_password:
		print("✅ 密码正确！")
		Main.flag = true
		is_unlocked = true
		texture_rect.visible = false
	else:
		error_label.text = "Unaccepted. Press Esc to close."
		line_edit.text = ""
		line_edit.grab_focus()

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		texture_rect.visible = false
		
