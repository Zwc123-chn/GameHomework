extends HBoxContainer

@export var icon_texture:Texture2D:
	set(new_val):
		$TextureRect.texture = new_val
@export var message_text:String:
	set(new_val):
		$Label.text = new_val
