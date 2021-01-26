extends "res://src/Actors/Actor.gd"


func _ready() -> void:
	set_physics_process(false) #deactivate enemy at start
	_velocity.x = -speed.x #go backwards 

func _on_TopDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("TopDetector").global_position.y: #check if a body is coming from the top 
		return
		get_node("CollisionShape2D").disabled = true
	queue_free() #killing


func _physics_process(delta: float) -> void:
	_velocity.y =+ gravity * delta 
	
	if is_on_wall(): #if enemy hits a wall, turn around 
		_velocity.x = _velocity.x * -1 
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y #makes the enemy turn around 


