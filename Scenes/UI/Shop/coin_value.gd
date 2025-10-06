extends HBoxContainer

@onready var G = Global

@onready var coin_value_label = $CoinValue
@onready var coin_value_button = $CoinValueButton

func update_label(coin_value, coin_value_cost):
	coin_value_label.text = "Upgrade Coin Value (Coin Value: %d ➡️ Coin Value: %d): " % [coin_value, coin_value + 1]
	coin_value_button.text = "%d Coins" % coin_value_cost

func _ready() -> void:
	update_label(G.coin_value, G.coin_value_upgrade_cost)

func _on_coin_value_button_pressed() -> void:
	if G.coin >= G.coin_value_upgrade_cost:
		G.coin -= G.coin_value_upgrade_cost
		G.coin_value += 1
		G.coin_value_upgrade_cost = int(G.coin_value_upgrade_base_cost * pow(1.5, G.coin_value))
	else:
		print("Not Enough Coins")
	
	update_label(G.coin_value, G.coin_value_upgrade_cost)
