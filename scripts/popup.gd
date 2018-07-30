extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var current_texture = 0
var textures = []
func _ready():
	get_node('close_button').connect("pressed", self, "_on_pressed")
	pass
	
func set_popup(o_textures):
	textures = o_textures
	var texture = textures[current_texture]
	get_node('tf').set_normal_texture(load(texture))
	get_node('tf').grab_focus()
	current_texture += 1
	
func _on_pressed():
	if current_texture < textures.size():
		set_popup(textures)
	else:
		hide()
