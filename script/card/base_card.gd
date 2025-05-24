class_name BaseCard
extends Control

@export var card_data = CardData.new()

func _ready():
	$Card.current_texture = card_data.icon
	$Card.reset_texture()
	$Card/Label.z_index = 100
	scale = Vector2(0.25, 0.25)  # 1/4 크기로 축소	

func make_card(data : CardData) -> Control:
	var new_card : Control
	if !data:
		return null
	match data.card_type:
		"fireball":
			new_card = preload("res://scene/card/fireball_card.tscn").instantiate()
	new_card.card_data = data
	return new_card
