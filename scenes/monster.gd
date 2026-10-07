extends CharacterBody2D
@export var bullet_scn: PackedScene
@onready var shoot_timer = $ShootTimer
@onready var muzzle = $Marker2D
var target_player: Node2D = null

func _ready():
	if shoot_timer:
		shoot_timer.timeout.connect(_shoot_bullet)
		shoot_timer.paused = false


func _physics_process(delta):
	velocity = Vector2.ZERO
	move_and_slide()

	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		target_player = players[0]
func _shoot_bullet():
	if !target_player:

		return
	if !bullet_scn:
		return
	var bullet_dir = Vector2.LEFT  # 固定水平向左发射
	var bullet = bullet_scn.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = muzzle.global_position
	bullet.dir = bullet_dir
