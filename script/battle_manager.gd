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
var hand = []

func _ready():
	change_state(BattleState.SETUP)

func change_state(new_state: BattleState):
	current_state = new_state
	match current_state:
		BattleState.SETUP:
			deck = Global.get_deck()
			deck.shuffle()
			change_state(BattleState.DRAW)
		BattleState.DRAW:
			if len(hand) == 0:
				draw_n_cards(Global.initial_draw)
			else:
				draw_n_cards(Global.draw_card)

		BattleState.SELECT:
			#wait_for_player_selection()
			pass

		BattleState.CARD:
			#activate_selected_cards()
			pass
	
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
			hand.append(deck.pop_back())
