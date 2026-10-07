extends VBoxContainer

@export var row_prefab:PackedScene
@export var ui_panel:Control


func add_log_line(icon:Texture2D, msg:String):

	if ui_panel.visible == false:
		ui_panel.visible = true
	var new_row = row_prefab.instantiate()
	new_row.icon_texture = icon
	new_row.message_text = msg
	
	add_child(new_row)
