# script: spawner_ground

extends Node2D

export var scene_name = "background_nuvens"
export var horizontal_space = 980
const AMOUNT_TO_FILL_VIEW = 30
var scn_ground = null
export var speed = 1.0
export var y_variation = 50.0

func _ready():
	self.scn_ground = load("res://scenes/"+scene_name+".tscn")

	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
	pass

func spawn_and_move():
	spawn_ground()
	go_next_pos()
	pass

func spawn_ground():
	var new_ground = scn_ground.instance()
	var new_pos = get_pos()
	new_pos.y += rand_range(-self.y_variation,self.y_variation)
	new_ground.set_pos(new_pos)
	new_ground.get_node("Sprite").speed = self.speed
           
	new_ground.connect("exit_tree", self, "spawn_and_move")
	get_node("container").add_child(new_ground)
	pass

func go_next_pos():
	set_pos( get_pos() + Vector2(horizontal_space, 0) )
	pass

