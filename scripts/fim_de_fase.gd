extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	add_to_group(game.GROUP_END_OF_LEVEL)
	pass