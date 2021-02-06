extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")

var paused: = false setget setPaused

func _ready() -> void:
	PlayerData.connect("scoreUpdated", self, "update_interface")
	PlayerData.connect("playerDied", self, "_on_PlayerData_player_died")
	update_interface()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != "You died!":
		#setPaused(paused) #or use self.paused = !paused 
		self.paused = !paused 
		scene_tree.set_input_as_handled() #only this function will process input event (so, when other stuff uses the same action, like pressing an arrow key, it will only do it in this specific fucntion

func setPaused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value 

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score
		
func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = "You died!"
	
