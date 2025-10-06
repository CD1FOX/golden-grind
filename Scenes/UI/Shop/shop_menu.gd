extends Control

@onready var G = Global

@onready var speed_label = $Panel/VBoxContainer/Speed/Speed
@onready var speed_button = $Panel/VBoxContainer/Speed/SpeedUpgradeButton

@onready var magnet_label = $Panel/VBoxContainer/Magnet/Magnet
@onready var magnet_button = $Panel/VBoxContainer/Magnet/MagnetUpgradeButton

@onready var coin_value_label = $Panel/VBoxContainer/CoinValueUpgrade/CoinValue
@onready var coin_value_button = $Panel/VBoxContainer/CoinValueUpgrade/CoinValueButton

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Open Shop"):
		visible = !visible
	
	update_label(speed_label, speed_button, "Speed", G.speed_level, G.speed_cost)
	update_label(magnet_label, magnet_button, "Magnet Radius", G.magnet_level, G.magnet_cost)
	update_label(coin_value_label, coin_value_button, "Coin Value", G.coin_value, G.coin_value_upgrade_cost)

func update_label(label_node: Label, button_node: Button, upgrade_name: String, current_level: int, cost: int) -> void:
	label_node.text = "Upgrade %s (Level %d ➡️ Level %d): " % [upgrade_name, current_level, current_level + 1]
	button_node.text = "%d Coins" % cost

	

func _on_magnet_upgrade_button_pressed() -> void:
	if G.coin >= G.magnet_cost:
		G.coin -= G.magnet_cost
		G.magnet_level += 1
		G.speed_cost = int(G.magnet_base_cost * pow(1.5, G.magnet_level))
		G.magnet_radius = Vector2((G.magnet_radius.x + 1.0), (G.magnet_radius.y + 1.0))
	else:
		print("Not Enough Coins")

func _on_speed_upgrade_button_pressed() -> void:
	if G.coin >= G.speed_cost:
		G.coin -= G.speed_cost
		G.speed_level += 1
		G.speed_cost = int(G.speed_base_cost * pow(1.5, G.speed_level))
		G.speed += 20
	else:
		print("Not Enough Coins")

func _on_coin_value_button_pressed() -> void:
	if G.coin >= G.coin_value_upgrade_cost:
		G.coin -= G.coin_value_upgrade_cost
		G.coin_value += 1
		G.coin_value_upgrade_cost = int(G.coin_value_upgrade_base_cost * pow(1.5, G.coin_value))
	else:
		print("Not Enough Coins")
