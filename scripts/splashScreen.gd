extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tween  = get_node("tween")
export var splash_screen_time = 1.0
func _ready():
	tween.interpolate_callback(self, splash_screen_time, "change_state")
	tween.start()
	pass

func change_state():
	stage_manager.change_stage(stage_manager.STAGE_MENU, null, true)
	
	