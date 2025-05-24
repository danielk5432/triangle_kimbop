extends Node

var player_deck: Array[CardData] = []

var hand_card_limit = 12
var initial_draw = 8
var draw_card = 4

var id = 0

var selectable = false

func get_deck() -> Array:
	if len(player_deck) < 5:
		for i in range(5):
			player_deck.append(FireballData.new())
	return player_deck

func make_card(data : CardData) -> BaseCard:
	if !data:
		return null
	match data.name:
		"fireball":
			return preload("res://scene/card/fireball_card.tscn").instantiate()
	return null
	
func get_card_id() -> int:
	id += 1
	return id
