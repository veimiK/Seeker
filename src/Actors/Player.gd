extends Actor

onready var current_anim: AnimationPlayer = get_node("AnimationPlayer")

export var topkill_impulse: = 1000.0
func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_topkill_velocity(_velocity, topkill_impulse)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()
	
	#queue_free() #kill player 
	PlayerData.deaths += 1 #add 1 to death score


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	animate_movement(direction)
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2: 
	speed.x=300
	speed.y=775
	var out: = linear_velocity
	out.x = speed.x * direction.x 
	out.y += gravity * get_physics_process_delta_time()
	#print(linear_velocity)
	#print(direction)
	#print(speed)
	if direction.y == -1.0:
		out.y = speed.y * direction.y 
	if is_jump_interrupted:
		out.y = 0.0 
	return out 

func calculate_topkill_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity #start velocity
	out.y = -impulse #jump off of head
	return out

func die() -> void:
	PlayerData.deaths += 1
	queue_free()

func animate_movement(
		direction: Vector2) -> void:
	if direction.x > 0:
		current_anim.play("walking")
	elif direction.x < 0:
		current_anim.play("walking_left")
	elif direction.x == 0:
		current_anim.stop()


