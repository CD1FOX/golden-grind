extends HBoxContainer

@onready var G = Global

@onready var speed_label = $Speed
@onready var speed_button = $SpeedUpgradeButton
@onready var speed_unlock_button = $SpeedUnlockButton

func _process(_delta: float) -> void:
	if G.tier_list == 0:
		speed_label.text = "Unlock Speed Level %d - %d Upgrade: " % [G.tier_limit + 1, G.tier_limit + 5]
		speed_unlock_button.text = "Free"
	elif G.speed_level >= G.tier_limit:
		speed_label.text = "Unlock Speed Level %d - %d Upgrade: " % [G.tier_limit + 1, G.tier_limit + 5]
		speed_unlock_button.text = "%d Coins" % G.speed_unlock_cost
		speed_button.visible = false
		speed_unlock_button.visible = true
	else:
		speed_label.text = "Upgrade Movement Speed (Level %d ➡️ Level %d): " % [G.speed_level, G.speed_level + 1]
		speed_button.text = "%d Coins" % G.speed_cost

func _on_speed_upgrade_button_pressed() -> void:
	if G.coin >= G.speed_cost:
		G.coin -= G.speed_cost
		G.speed_level += 1
		G.speed += 20
		G.speed_cost = int(G.speed_base_cost * pow(1.5, G.speed_level))
	else:
		print("Not Enough Coins")

func _on_speed_unlock_button_pressed() -> void:
	if G.tier_list <= 0:
		G.tier_list = 1
		G.tier_limit = 5
	elif G.coin >= G.speed_unlock_cost:
		G.coin -= G.speed_unlock_cost
		G.speed_unlock_cost = int(G.speed_unlock_base_cost * pow(3, G.tier_list))
		G.tier_limit += 5
		G.tier_list += 1
	speed_button.visible = true
	speed_unlock_button.visible = false
