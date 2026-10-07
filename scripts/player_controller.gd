extends CharacterBody2D
@export_category("移动参数")
@export var double_press_interval := 0.3
@export var move_speed: float = 75.0
@export var acceleration: float = 600.0
@export var deceleration: float = 800.0
@export var jump_velocity: float = -190.0
# ========== 新增：水下参数 ==========
@export_category("水体浮力")
@export var water_move_speed:float = 55.0      #水里横向速度
@export var water_acceleration:float = 400.0
@export var water_deceleration:float = 600.0
@export var buoyancy:float = -120.0            #浮力（负数向上）
@export var water_gravity:float = 180.0       #水下微弱重力
@export var water_jump_boost:float = -220.0   #水里按跳跃上浮推力（调高力度）
var flying : bool = false
var last_space_press_time := -1000
var in_water:bool = false # 水体标记
@onready var sprite: Sprite2D = $Sprite2D
func _physics_process(delta: float) -> void:
	if in_water:
		handle_water_physics(delta) # 水下物理优先
	else:
		if !flying:
			apply_gravity(delta)
			handle_jump()
		else:
			handle_vertical_movement(delta)
	
	handle_horizontal_movement(delta)
	update_sprite_direction()
	move_and_slide()
# ========== 新增 水下物理 ==========
func handle_water_physics(delta:float):
	# 水平方向用水下加速度/速度
	var h_dir := Input.get_axis("move_left", "move_right")
	var target_h = h_dir * water_move_speed
	if h_dir !=0:
		velocity.x = move_toward(velocity.x, target_h, water_acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, water_deceleration * delta)
	
	# 浮力 + 水下重力
	velocity.y += water_gravity * delta
	velocity.y += buoyancy * delta
	
	var max_up_speed = -200.0 #上浮速度上限，防止无限加速
	# 按住jump持续上浮，无下潜逻辑
	if Input.is_action_pressed("jump"):
		velocity.y += water_jump_boost * delta
		# 限制最大上浮速度
		if velocity.y < max_up_speed:
			velocity.y = max_up_speed

# 原有重力逻辑不变
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
func handle_vertical_movement(delta:float) -> void:
	var direction := Input.get_axis("squat", "jump")
	var target_speed := direction * jump_velocity
	
	if direction != 0.0:
		velocity.y = move_toward(
				velocity.y,
				target_speed,
				acceleration * delta
		)
	else:
		velocity.y = move_toward(
				velocity.y,
				0.0,
				acceleration * delta
		)
# 修改水平移动：不在水里才用原来的参数；水里已经在handle_water_physics处理了
func handle_horizontal_movement(delta: float) -> void:
	if in_water:
		return #水下水平逻辑交给handle_water_physics，这里跳过
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * move_speed
	if direction != 0.0:
		velocity.x = move_toward(
				velocity.x,
				target_speed,
				acceleration * delta
		)
	else:
		velocity.x = move_toward(
				velocity.x,
				0.0,
				deceleration * delta
		)
func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
func update_sprite_direction() -> void:
	if velocity.x != 0.0:
		sprite.flip_h = velocity.x < 0.0
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly") and !event.is_echo():
		handle_space_pressed()
	
func handle_space_pressed() -> void:
	var current_time := Time.get_ticks_msec()
	var elapsed_time := current_time - last_space_press_time
	if elapsed_time <= double_press_interval * 1000.0:
		flying = not flying
		last_space_press_time = -1000
	else:
		last_space_press_time = current_time
# ========== 新增Area2D水体信号回调 ==========
func _on_water_body_entered(body:Node2D):
	if body == self:
		in_water = true
		# 进入水时，可以把飞行关掉，可选
		# flying = false
func _on_water_body_exited(body:Node2D):
	if body == self:
		in_water = false
func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
