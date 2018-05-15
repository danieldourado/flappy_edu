extends GridContainer

export var amount_of_levels 	= 40
const btn_choose_level		    = preload("res://scenes/btn_choose_level.tscn")

func _ready():
	self.create_buttons(self.amount_of_levels, self)
	pass

func create_buttons(amount_of_buttons, container):
	for i in range(1, amount_of_buttons+1):
		var new_button = btn_choose_level.instance()
		new_button.set_number(i)
		container.add_child(new_button)
		