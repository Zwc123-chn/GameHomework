extends Area2D

@onready var texture_rect: TextureRect = $TextureRect

func _ready():
	texture_rect.visible = false  # 初始隐藏
	body_entered.connect(_on_player_enter)
	body_exited.connect(_on_player_leave)

func _on_player_enter(body: Node2D):
	if body.is_in_group("Player"):
		texture_rect.visible = true
		print("玩家进入提示区域")

func _on_player_leave(body: Node2D):
	if body.is_in_group("Player"):
		texture_rect.visible = false
		print("玩家离开提示区域")
