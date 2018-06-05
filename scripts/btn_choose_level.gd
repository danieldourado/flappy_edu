extends TextureButton
const sprite_numbers = [
	preload("res://sprites/numbers/green/number_large_0.png"),
	preload("res://sprites/numbers/green/number_large_1.png"),
	preload("res://sprites/numbers/green/number_large_2.png"),
	preload("res://sprites/numbers/green/number_large_3.png"),
	preload("res://sprites/numbers/green/number_large_4.png"),
	preload("res://sprites/numbers/green/number_large_5.png"),
	preload("res://sprites/numbers/green/number_large_6.png"),
	preload("res://sprites/numbers/green/number_large_7.png"),
	preload("res://sprites/numbers/green/number_large_8.png"),
	preload("res://sprites/numbers/green/number_large_9.png")
]
var level = 0
func _ready():
	connect("pressed", self, "_on_pressed")
	pass

func _on_pressed():
	if game.level_current >= self.level:
		stage_manager.change_stage(stage_manager.STAGE_GAME, level)
	pass

func set_number(number):
	level = number
	for child in get_node('play_sprites').get_node('HBoxContainer').get_children():
		child.queue_free()
	
	for digit in utils.get_digits(number):
		var texture_frame = TextureFrame.new()
		texture_frame.set_texture(sprite_numbers[digit])
		get_node('play_sprites').get_node('HBoxContainer').add_child(texture_frame)
	
	decide_is_locked()
	
func decide_is_locked():
	if game.level_current < self.level:
		remove_child(get_node('play_sprites'))
	
