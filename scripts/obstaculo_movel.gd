extends StaticBody2D

onready var GarrasMoveis = get_node("GarrasMoveis")
onready var Position1 = get_node("Position1")
onready var Position2 = get_node("Position2")
onready var TweenNode = get_node("Tween")
onready var timer = get_node("Timer")
var current_target_position = null
export var speed = 2.0
export var mortal = true
export var delay_to_start = 0.1

func _ready():
	self.set_rot(self.get_global_transform().get_rotation())
	self.GarrasMoveis.set_pos(Position2.get_pos())
	
	if self.mortal:
		self.GarrasMoveis.add_to_group(game.GROUP_PIPES)
	if self.speed <=0: return
	timer.connect("timeout", self, "start")
	timer.set_wait_time(self.delay_to_start)
	timer.start()
	
func process(target_position):
	TweenNode.interpolate_property(GarrasMoveis, "transform/pos", GarrasMoveis.get_pos(),target_position, 
									self.speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.interpolate_callback(self, self.speed, "start")
	TweenNode.start()

func start():
	timer.stop()
	if self.current_target_position == Position1.get_pos():
		self.current_target_position = Position2.get_pos()
	else:
		self.current_target_position = Position1.get_pos()
	
	process(self.current_target_position)