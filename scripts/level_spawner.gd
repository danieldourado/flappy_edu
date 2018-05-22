extends Node2D

var bird = null
var new_level = null

func _ready():
	set_process(true)
	var level = load("res://fases/fase"+str(stage_manager.current_level)+".tscn")
	new_level = level.instance()
	bird = utils.get_main_node().get_node("bird")

func _process(delta):
	set_pos(Vector2(bird.get_pos().x, get_pos().y))
	if bird.get_state() == bird.STATE_FLAPPING:
		add_child(new_level)
		set_process(false)

