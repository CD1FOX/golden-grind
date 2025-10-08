extends HBoxContainer

@onready var G = Global

@onready var magnet_label = $Magnet
@onready var magnet_button = $MagnetUpgradeButton
@onready var magnet_unlock_button = $MagnetUnlockButton
@onready var magnet_first_unlock_button = $MagnetFirstUnlock

func _process(_delta: float) -> void:
	if G.magnet_tier_list == 0:
		magnet_label.text = "Unlock  Magnet Skill: " 
		magnet_first_unlock_button.text = "5000 Coins"
	elif G.magnet_level >= G.magnet_tier_limit:
		magnet_label.text = "Unlock Magnet Level %d - %d Upgrade (Tier: %d): " % [G.magnet_tier_limit + 1, G.magnet_tier_limit + 5, G.magnet_tier_list]
		magnet_unlock_button.text = "%d Coins" % G.magnet_unlock_cost
		magnet_button.visible = false
		magnet_unlock_button.visible = true
	else:
		magnet_label.text = "Upgrade Magnet Skill (Level %d ➡️ Level %d): " % [G.magnet_level, G.magnet_level + 1]
		magnet_button.text = "%d Coins" % G.magnet_cost

func _on_magnet_upgrade_button_pressed() -> void:
	if G.coin >= G.magnet_cost:
		G.coin -= G.magnet_cost
		G.magnet_level += 1
		G.magnet_cost = int(G.magnet_base_cost * pow(1.5, G.magnet_level))
		G.magnet_radius = Vector2((G.magnet_radius.x + 1.0), (G.magnet_radius.y + 1.0))
	else:
		print("Not Enough Coins")

func _on_magnet_unlock_button_pressed() -> void:
	if G.coin >= G.magnet_unlock_cost:
		G.coin -= G.magnet_unlock_cost
		G.magnet_unlock_cost = int(G.magnet_unlock_base_cost * pow(4, G.magnet_tier_list))
		G.magnet_tier_limit += 5
		G.magnet_tier_list += 1
	else:
		print("Not Enough Coins")
		return
	magnet_button.visible = true
	magnet_unlock_button.visible = false


func _on_magnet_first_unlock_pressed() -> void:
	if G.coin >= 5000:
		G.coin -= 5000
		G.magnet_tier_limit += 5
		G.magnet_tier_list += 1
	else:
		print("Not Enough Coins")
		return
	magnet_first_unlock_button.visible = false
	magnet_button.visible = true
