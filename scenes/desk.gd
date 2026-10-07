extends Area2D
# 引用子节点TextureRect
@onready var desk_img: TextureRect = $TextureRect
func _ready():
	# 游戏一开始，图片默认隐藏
	desk_img.visible = false
	
	# 连接信号（也可以在编辑器可视化连接）
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
# 有物理体进入这个Area2D
func _on_body_entered(body: Node2D):
	# 判断进入的物体是不是玩家（你的玩家节点名字叫Player就写"Player"）
	if body.name == "Player":
		desk_img.visible = true
# 物体离开Area2D
func _on_body_exited(body: Node2D):
	if body.name == "Player":
		desk_img.visible = false
