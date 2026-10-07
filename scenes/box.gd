extends Area2D
@export var correct_password: String = "1234"
@onready var texture_rect: TextureRect = $TextureRect
@onready var line_edit: LineEdit = $TextureRect/LineEdit
@onready var error_label: Label = $TextureRect/Label
@onready var hint_label: Label = $Label
@onready var good_label: Label = $Label2
var is_unlocked: bool = false
var player_in_range: bool = false

func _ready():
	texture_rect.visible = false
	hint_label.visible = false
	good_label.visible = false
	error_label.text = "Enter 4 numbers"
	body_entered.connect(_on_player_enter)
	body_exited.connect(_on_player_exit)
	line_edit.text_submitted.connect(_on_confirm)

func _on_player_enter(body: Node2D):
	if body.is_in_group("Player"):
		player_in_range = true
		hint_label.visible = true

func _on_player_exit(body: Node2D):
	if body.is_in_group("Player"):
		player_in_range = false
		texture_rect.visible = false
		hint_label.visible = false
		good_label.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and player_in_range and not is_unlocked:
		if not texture_rect.visible:
			hint_label.visible = false
			texture_rect.visible = true
			line_edit.text = ""
			error_label.text = "Enter 4 numbers"
			line_edit.grab_focus()

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		texture_rect.visible = false
		if player_in_range:
			hint_label.visible = true

func _on_confirm(text: String): 
	if line_edit.text == correct_password:
		good_label.visible = true 
		Main.flag = true
		is_unlocked = true
		texture_rect.visible = false
	else:
		error_label.text = "Unaccepted. Press Esc to close."
		line_edit.text = ""
		line_edit.grab_focus()
