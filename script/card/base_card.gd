class_name BaseCard
extends Control

signal card_selected(card: BaseCard)
signal card_deselected(card: BaseCard)

@export var card_data = CardData.new()


func _ready():
	$Card.current_texture = card_data.icon
	$Card.reset_texture()
	$Card.connect("card_selected", _card_selected)
	$Card.connect("card_deselected", _card_deselected)
	
	
func set_card_position(target_pos):
	$Card.handle_movement_r(target_pos, true)

func set_index(i: int):
	$Card/Index.text = str(i)

func _card_selected():
	card_selected.emit(self)

func _card_deselected():
	card_deselected.emit(self)

func select_reset():
	$Card.deselect()
