extends HBoxContainer

@onready var G = Global

@onready var coin_value_label = $CoinValue
@onready var coin_value_button = $CoinValueUpgrade
@onready var coin_value_unlock_button = $CoinValueUnlockButton
@onready var coin_value_first_unlock_button = $CoinValueFirstUnlockButton

func _process(_delta: float) -> void:
	if G.coin_tier_list == 0:
		coin_value_label.text = "Unlock Coin Value Upgrade: " 
		coin_value_first_unlock_button.text = "500 Coins"
	elif G.coin_value >= G.coin_tier_limit:
		coin_value_label.text = "Unlock Coin Value %d - %d Upgrade (Tier: %d): " % [G.coin_tier_limit + 1, G.coin_tier_limit + 5, G.coin_tier_list]
		coin_value_unlock_button.text = "%d Coins" % G.coin_unlock_cost
		coin_value_button.visible = false
		coin_value_unlock_button.visible = true
	else:
		coin_value_label.text = "Upgrade Coin Value (Value %d ➡️ Value %d): " % [G.coin_value, G.coin_value + 1]
		coin_value_button.text = "%d Coins" % G.coin_value_upgrade_cost

func _on_coin_value_upgrade_pressed() -> void:
	if G.coin >= G.coin_value_upgrade_cost:
		G.coin -= G.coin_value_upgrade_cost
		G.coin_value += 1
		G.coin_value_upgrade_cost = int(G.coin_value_upgrade_base_cost * pow(1.5, G.coin_value))
	else:
		print("Not Enough Coins")

func _on_coin_value_unlock_button_pressed() -> void:
	if G.coin >= G.coin_unlock_cost:
		G.coin -= G.coin_unlock_cost
		G.coin_unlock_cost = int(G.coin_unlock_base_cost * pow(2, G.coin_tier_list))
		G.coin_tier_limit += 5
		G.coin_tier_list += 1
	else:
		print("Not Enough Coins")
		return
	coin_value_button.visible = true
	coin_value_unlock_button.visible = false

func _on_coin_value_first_unlock_button_pressed() -> void:
	if G.coin >= 500:
		G.coin -= 500
		G.coin_tier_limit += 5
		G.coin_tier_list += 1
	else:
		print("Not Enough Coins")
		return
	coin_value_first_unlock_button.visible = false
	coin_value_button.visible = true
