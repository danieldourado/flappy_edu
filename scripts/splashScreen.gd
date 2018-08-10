extends Node2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tween  = get_node("tween")
export var splash_screen_time = 1.0
func _ready():
	tween.interpolate_callback(self, splash_screen_time, "change_state")
	tween.start()
	pass

func change_state():
	game.level_current = load_current_level_number()
	stage_manager.change_stage(stage_manager.STAGE_SELECT_LEVEL, game.level_current, true)

func load_current_level_number():
	var load_current_level_number = 1
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return 1

	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = save_game.get_line()
		if int(current_line) == 0:
			continue
			
		load_current_level_number = int(current_line)
		print(load_current_level_number)
		
	save_game.close()
	return load_current_level_number