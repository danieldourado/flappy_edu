extends StaticBody2D

const SMOOTH_SPEED = 2
var repos = Vector2()
var repos_velo = Vector2()
var position = Vector2()
var garras_moveis = null
export var distance_to_travel = 300
var start_pos = 0
export var speed = 10
export var mortal = true

func _ready():
	self.garras_moveis = get_node("garras_moveis")
	self.start_pos = self.get_pos()
	if self.mortal:
		add_to_group(game.GROUP_PIPES)
	set_process(true)
	pass
	
func _process(delta):
	var new_pos = 0
	if self.distance_to_travel > 0:
		new_pos = Vector2(self.get_pos().x,self.get_pos().y+self.speed);
		if self.get_pos().y - self.start_pos.y > self.distance_to_travel:
			self.distance_to_travel *= -1
	
	
	if self.distance_to_travel < 0:
		new_pos = Vector2(self.get_pos().x,self.get_pos().y-self.speed);
		if self.get_pos().y - self.start_pos.y < self.distance_to_travel:
			self.distance_to_travel *= -1
		
	self.set_pos(new_pos)
	