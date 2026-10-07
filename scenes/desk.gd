extends Area2D
@onready var desk_img: TextureRect = $TextureRect
func _ready():
	desk_img.visible = false
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
func _on_body_entered(body: Node2D):
	if body.name == "Player":
		desk_img.visible = true
func _on_body_exited(body: Node2D):
	if body.name == "Player":
		desk_img.visible = false
