class_name FireballData
extends CardData

func _init():
	name = "fireball"
	icon = load("res://resource/fireball_card.png")
	damage = 3.0
	damage_growth = 2.0
	break_chance = 0.06
	break_chance_growth = -0.02
	card_type = "Basic"
	symbol = "+"
