extends Button

func _on_button_up() -> void:
	PlayerData.setScore(0)
	get_tree().paused = false
	get_tree().reload_current_scene()
	return
	
