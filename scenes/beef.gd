extends Area2D
@export var item_type: String = "beef"

func _on_body_entered(body:Node2D):
	if body.name == "Player":
		Main.pickup_item(item_type)
		queue_free()

func _ready():
	body_entered.connect(_on_body_entered)
