class_name FireballData
extends CardData

var level: int

func _init(n : int = 1):
	id = Global.get_card_id()
	level = n
	set_data(n)
	

func set_data(n : int):
	name = "fireball"
	icon = load("res://resource/fireball_card.png")
	damage = 3.0
	damage_growth = 2.0
	break_chance = 0.06
	break_chance_growth = -0.02
	card_type = "Basic"
	symbol = "+"
	for i in range(n-1):
		upgrade()

func round_reset():
	set_data(level)
