tool
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #may use $AnimationPlayer instead 

export var next_scene: PackedScene 

func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty." if not next_scene else "" #warning about the scene
	
func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished") #wait for fade_in to finish
	get_tree().change_scene_to(next_scene) #change to the next scene 
	



