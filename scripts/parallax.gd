extends Sprite

var speed = 1.0
onready var bird = utils.get_main_node().get_node("bird")

func _ready():
	set_process(true)
	pass

func _process(delta):
	self.set_pos(Vector2(self.get_pos().x+self.speed, self.get_pos().y))
	
	if(self.bird.get_state() == self.bird.STATE_HIT || self.bird.get_state() == self.bird.STATE_GROUNDED):
		set_process(false)
