extends Node2D

func _ready():
	var level = load("res://fases/fase"+str(stage_manager.current_level)+".tscn")
	var new_level = level.instance()
	add_child(new_level)