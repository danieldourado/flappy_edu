extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	get_node('close_button').connect("pressed", self, "_on_pressed")
	pass

func set_popup(texture):
	get_node('tf').set_normal_texture(texture)
	get_node('tf').grab_focus()
func _on_pressed():
	hide()
