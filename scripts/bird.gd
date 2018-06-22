# script: bird

extends RigidBody2D

onready var state = FlyingState.new(self)
var prev_state

export var speed = 50
export var gravity_force = 2
export var flap_force = 200
export var x_offset = 100


const STATE_FLYING   = 0
const STATE_FLAPPING = 1
const STATE_HIT      = 2
const STATE_GROUNDED = 3
const STATE_END_OF_LEVEL = 4

signal state_changed

func _ready():
	set_process_input(true)
	set_process_unhandled_input(true)
	set_fixed_process(true)
	
	add_to_group(game.GROUP_BIRDS)
	connect("body_enter", self, "_on_body_enter")
	pass

func _fixed_process(delta):
	state.update(delta)
	pass

func _input(event):
	state.input(event)
	pass

func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)
	pass

func _on_body_enter(other_body):
	if state.has_method("on_body_enter"):
		state.on_body_enter(other_body)
	pass

func set_state(new_state):
	state.exit()
	prev_state = get_state()
	
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
	elif new_state == STATE_END_OF_LEVEL:
		state = EndOfLevelState.new(self)
	
	emit_signal("state_changed", self)
	pass

func get_state():
	if state extends FlyingState:
		return STATE_FLYING
	elif state extends FlappingState:
		return STATE_FLAPPING
	elif state extends HitState:
		return STATE_HIT
	elif state extends GroundedState:
		return STATE_GROUNDED
	elif state extends EndOfLevelState:
		return STATE_END_OF_LEVEL
	pass

# class FlyingState ----------------------------------------------------

class FlyingState:
	var bird
	var prev_gravity_scale
	
	func _init(bird):
		self.bird = bird
		bird.get_node("anim").play("flying")
		bird.get_node("anim_sprite").play("flying")
		bird.set_linear_velocity(Vector2(bird.speed, 0))
		bird.set_rot(deg2rad(0))
		bird.set_angular_velocity(0)
		
		prev_gravity_scale = bird.gravity_force
		bird.set_gravity_scale(0)
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		bird.set_gravity_scale(prev_gravity_scale)
		bird.get_node("anim").stop()
		#bird.get_node("anim_sprite").set_pos(Vector2(0, 0))
		pass

# class FlappingState --------------------------------------------------

class FlappingState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.get_node("anim_sprite").play("flap")
		bird.set_linear_velocity(Vector2(bird.speed, bird.get_linear_velocity().y))
		flap()
		pass
	
	func update(delta):
		if rad2deg(bird.get_rot()) > 30/2:
			bird.set_rot(deg2rad(30/2))
			bird.set_angular_velocity(0)
	
		if bird.get_linear_velocity().y > 0:
			bird.set_angular_velocity(1.5)
		pass
	
	func input(event):
		if event.is_action_pressed("flap"):
			flap()
		pass
	
	func unhandled_input(event):
		if event.type != InputEvent.MOUSE_BUTTON or !event.is_pressed() or event.is_echo():
			return
		
		if event.button_index == BUTTON_LEFT:
			flap()
		pass
	
	func on_body_enter(other_body):
		if other_body.is_in_group(game.GROUP_PIPES):
			bird.set_state(bird.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
		elif other_body.is_in_group(game.GROUP_END_OF_LEVEL):
			bird.set_state(bird.STATE_END_OF_LEVEL)
		pass
	
	func flap():
		bird.set_linear_velocity(Vector2(bird.get_linear_velocity().x, -bird.flap_force))
		bird.set_angular_velocity(-3)
		bird.get_node("anim").play("flap")
		
		audio_player.play("sfx_wing")
		pass
	
	func exit():
		pass

# class HitState -------------------------------------------------------

class HitState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.set_linear_velocity(Vector2(0, 0))
		bird.set_angular_velocity(2)
		bird.get_node("anim_sprite").play("flying")
		var other_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(other_body)
		
		audio_player.play("sfx_hit")
		audio_player.play("sfx_die")
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func on_body_enter(other_body):
		if other_body.is_in_group(game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
		if other_body.is_in_group(game.GROUP_PIPES):
			bird.add_collision_exception_with(other_body)
		
		pass
	
	func exit():
		pass

# class GroundedState --------------------------------------------------

class GroundedState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.set_linear_velocity(Vector2(0, 0))
		bird.set_angular_velocity(0)
		bird.get_node("anim_sprite").play("idle")
		if bird.prev_state != bird.STATE_HIT:
			audio_player.play("sfx_hit")
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
		
# class EndOfLevelState ----------------------------------------------------

class EndOfLevelState:
	var bird
	var prev_gravity_scale
	
	func _init(bird):
		self.bird = bird
		game.score_current += 1
		bird.get_node("anim").play("flying")
		bird.get_node("anim_sprite").play("flying")
		bird.set_linear_velocity(Vector2(bird.speed, 0))
		bird.set_rot(deg2rad(0))
		bird.set_angular_velocity(0)
		prev_gravity_scale = bird.gravity_force
		bird.set_gravity_scale(0)
		stage_manager.decide_if_show_pop_up(stage_manager.STAGE_GAME, stage_manager.current_level, stage_manager.END)
		if game.level_current <=stage_manager.current_level:
			game.level_current = stage_manager.current_level+1
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
