extends Sprite

const background_numbers = [
	preload("res://sprites/interface/fases/bg01.jpg"),
	preload("res://sprites/interface/fases/bg02.jpg"),
	preload("res://sprites/interface/fases/bg03.jpg"),
	preload("res://sprites/interface/fases/bg04.jpg")
]
var amount_of_levels = 10
func _ready():
	if game.level_current <= amount_of_levels*4:
		set_background(3)
	if game.level_current <= amount_of_levels*3:
		set_background(2)
	if game.level_current <= amount_of_levels*2:
		set_background(1)
	if game.level_current <= amount_of_levels:
		set_background(0)
	
		
func set_background(background_number):
	var texture_frame = TextureFrame.new()
	texture_frame.set_texture(background_numbers[background_number])
	add_child(texture_frame)
	