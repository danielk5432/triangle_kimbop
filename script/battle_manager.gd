extends Node2D

enum BattleState {
	SETUP,
	DRAW,
	SELECT,
	CARD,
	BREAK,
	ENEMY,
	END
}

var current_state: BattleState = BattleState.SETUP

#@onready var player_deck = $PlayerDeck
#@onready var enemy_manager = $EnemyManager
@onready var graveyard = []
var deck : Array
var hand_data : Array[CardData]
var hand_cards : Array[BaseCard]
var selected_cards : Array[BaseCard]
var card_idx : int = 0

func _ready():
	change_state(BattleState.SETUP)

func _on_card_selected(card: BaseCard):
	card.select_order = selected_cards.size()
	selected_cards.append(card)
	card.show_order_label(card.select_order)

func change_state(new_state: BattleState):
	var before_state = current_state
	current_state = new_state
	match current_state:
		BattleState.SETUP:
			deck = Global.get_deck()
			deck.shuffle()
			change_state(BattleState.DRAW)
		BattleState.DRAW:
			if len(hand_data) == 0:
				draw_n_cards(Global.initial_draw)
			else:
				draw_n_cards(Global.draw_card)
			make_hand_cards()
			for card in hand_cards:
				card.connect("card_selected", _card_selected)
				card.connect("card_deselected", _card_deselected)
			change_state(BattleState.SELECT)
		BattleState.SELECT:
			Global.selectable = true

		BattleState.CARD:
			Global.selectable = false
			print(hand_cards)
			print(selected_cards)
			if len(selected_cards) <= card_idx:
				change_state(BattleState.ENEMY)
				
			change_state(BattleState.BREAK)
		BattleState.BREAK:
			#resolve_card_destruction()
			pass

		BattleState.ENEMY:
			#enemy_turn()
			pass

		BattleState.END:
			#resolve_battle_end()
			pass

func draw_n_cards(n : int):
	for i in range(n):
		if !deck.is_empty():
			hand_data.append(deck.pop_back())

func make_hand_cards():
	var spacing = 350  # 카드 간 간격
	var y = 2000        # 화면 아래쪽 위치 (필요시 조정)
	var x = 1900
	var screen_width = get_viewport_rect().size.x
	var total_width = hand_data.size() * spacing
	var start_x = (screen_width - total_width) / 2.0 + x

	for i in range(hand_data.size()):
		var card_data = hand_data[i]
		var target_pos = Vector2(start_x + i * spacing, y)
		var new_card = Global.make_card(card_data)
		new_card.card_data = card_data
		$UI.add_child(new_card)
		new_card.set_card_position(target_pos)
		hand_cards.append(new_card)

func arrange_cards(cards : Array, y : int = 2000, spacing : int = 350):
	var x = 1900
	var screen_width = get_viewport_rect().size.x
	var total_width = cards.size() * spacing
	var start_x = (screen_width - total_width) / 2.0 + x
	for i in range(cards.size()):
		var target_pos = Vector2(start_x + i * spacing, y)
		var new_card = cards[i]
		new_card.set_card_position(target_pos)
	

func _card_selected(sel_card : BaseCard):
	sel_card.set_index(len(selected_cards) + 1)
	selected_cards.append(sel_card)

func _card_deselected(sel_card : BaseCard):
	for i in range(len(selected_cards)):
		if sel_card == selected_cards[i]:
			selected_cards.pop_at(i)
			break
	for i in range(len(selected_cards)):
		selected_cards[i].set_index(i+1)
	
func _on_button_pressed():
	#check if hand is not empty
	if current_state == BattleState.SELECT:
		del_selected_in_hand()
		arrange_cards(hand_cards)
		arrange_cards(selected_cards, 1300)
	
		change_state(BattleState.CARD)

func del_selected_in_hand():
	var del_cards = []
	for i in range(len(hand_cards)):
		var idx = selected_cards.find(hand_cards[i])
		hand_cards[i].select_reset()
		if idx != -1:
			del_cards.append(idx)
	del_cards.sort()
	del_cards.reverse()
	for i in del_cards:
		hand_cards.pop_at(i)
