# script: stage_manager

extends CanvasLayer

const STAGE_GAME = "res://stages/game_stage.tscn"
const STAGE_MENU = "res://stages/menu_stage.tscn"
const STAGE_SELECT_LEVEL = "res://stages/select_level_stage.tscn"
const pop_up_scene = preload("res://scenes/pop_up.tscn")

var is_changing = false

signal stage_changed

func _ready():
	pass

var current_level = 1
func change_stage(stage_path, level = 1, is_splash_screen=false):
	if is_changing: return
	
	is_changing = true
	get_tree().get_root().set_disable_input(true)
	
	if stage_path != STAGE_GAME:
		audio_player.play("sfx_menu_music.ogg")
	
	if not is_splash_screen:
		get_node("anim").play("fade_in")
		audio_player.play("sfx_swooshing")
		yield(get_node("anim"), "finished")
	
	# change stage
	if level != null: current_level = level
	get_tree().change_scene(stage_path)
	emit_signal("stage_changed")
	
	# fade from black
	if not is_splash_screen:
		get_node("anim").play("fade_out")
		yield(get_node("anim"), "finished")
	
	if is_splash_screen and false:
		get_node("anim").play("fade_in")
		audio_player.play("sfx_swooshing")
		yield(get_node("anim"), "finished")	
		get_node("anim").play("fade_out")
		yield(get_node("anim"), "finished")

	is_changing = false
	get_tree().get_root().set_disable_input(false)
	decide_if_show_pop_up(stage_path, game.level_current, BEGGINING)
	pass
	
func decide_if_show_pop_up(stage_path, level=1, period=BEGGINING):
	for pop_up in pop_ups:
		if pop_up['scene'] == stage_path && pop_up['level'] == level && pop_up['period'] == period:
			show_pop_up(pop_up)

func show_pop_up(pop_up):
	var new_pop_up = pop_up_scene.instance()
	new_pop_up.set_popup(pop_up['texture'])
	add_child(new_pop_up)
	
var BEGGINING="beggining"
var END="end"

var pop_ups = [
	{'scene':STAGE_SELECT_LEVEL,'level':1,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_02.png")},
	{'scene':STAGE_SELECT_LEVEL,'level':1,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_01.png")},
	{'scene':STAGE_GAME,'level':1,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_03.png")},
	{'scene':STAGE_GAME,'level':10,'period':END,'texture':preload("res://sprites/interface/popups/POP UP_04.png")},
	{'scene':STAGE_GAME,'level':11,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_05.png")},
	{'scene':STAGE_GAME,'level':20,'period':END,'texture':preload("res://sprites/interface/popups/POP UP_06.png")},
	{'scene':STAGE_GAME,'level':21,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_07.png")},
	{'scene':STAGE_GAME,'level':30,'period':END,'texture':preload("res://sprites/interface/popups/POP UP_08.png")},
	{'scene':STAGE_SELECT_LEVEL,'level':31,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_10.png")},
	{'scene':STAGE_SELECT_LEVEL,'level':31,'period':BEGGINING,'texture':preload("res://sprites/interface/popups/POP UP_09.png")},
]