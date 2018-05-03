extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var rotation_velocity = 1.0

func _ready():
	set_process(true)
	add_to_group(game.GROUP_PIPES)
	pass
	
func _process(delta):
	var rotation = self.get_rot()
	self.set_rot(rotation+rotation_velocity*0.01)
