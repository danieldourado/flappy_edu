extends GridContainer

export var amount_of_levels 	= 10
const btn_choose_level = preload("res://scenes/btn_choose_level.tscn")

func _ready():
	self.create_buttons(self.amount_of_levels, self)
	pass

func create_buttons(amount_of_buttons, container):
	var start_range = 1
	if game.level_current <= amount_of_levels*4:
		start_range = 31
		amount_of_buttons = 40
	if game.level_current <= amount_of_levels*3:
		start_range = 21
		amount_of_buttons = 30
	if game.level_current <= amount_of_levels*2:
		start_range = 11
		amount_of_buttons = 20
	if game.level_current <= amount_of_levels:
		start_range = 1
		amount_of_buttons = 10
	
	for i in range(start_range, amount_of_buttons+1):
		var new_button = btn_choose_level.instance()
		new_button.set_number(i)
		container.add_child(new_button)
		