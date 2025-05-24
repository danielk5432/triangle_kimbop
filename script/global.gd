extends Node

var fireball_scene = load("res://scene/card/fireball_card.tscn")
var fireball_instance = fireball_scene.instantiate()
var player_deck: Array[CardData] = []

var hand_card_limit = 12
var initial_draw = 8
var draw_card = 4

func get_deck() -> Array:
	if len(player_deck) < 5:
		for i in range(5):
			player_deck.append(fireball_instance.card_data.duplicate(true))
	return player_deck

func make_card(data : CardData) -> Control:
	if !data:
		return null
	match data.name:
		"fireball":
			return preload("res://scene/card/fireball_card.tscn").instantiate()
	return null
