extends StaticBody2D

onready var GarrasMoveis = get_node("GarrasMoveis")
onready var Position1 = get_node("Position1")
onready var Position2 = get_node("Position2")
onready var TweenNode = get_node("Tween")
var current_target_position = null
export var speed = 2
export var mortal = true

func _ready():
	self.set_rot(self.get_global_transform().get_rotation())
	self.GarrasMoveis.set_pos(Position2.get_pos())
	if self.mortal:
		add_to_group(game.GROUP_PIPES)
	done()
	
func process(target_position):
	TweenNode.interpolate_property(GarrasMoveis, "transform/pos", GarrasMoveis.get_pos(),target_position, 
									self.speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.interpolate_callback(self, self.speed, "done")
	TweenNode.start()

func done():
	if self.current_target_position == Position1.get_pos():
		self.current_target_position = Position2.get_pos()
	else:
		self.current_target_position = Position1.get_pos()
	
	process(self.current_target_position)