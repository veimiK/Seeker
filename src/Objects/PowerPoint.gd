extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export var score: = 1
	

func _on_body_entered(body: Node) -> void:
	picked()
	
func picked() -> void:
	anim_player.play("fade")
	PlayerData.score += score
