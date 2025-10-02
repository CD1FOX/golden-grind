extends Control

@onready var speed_label = $Panel/VBoxContainer/Speed/Speed
@onready var speed_button = $Panel/VBoxContainer/Speed/SpeedUpgradeButton

@onready var magnet_label = $Panel/VBoxContainer/Magnet/Magnet
@onready var magnet_button = $Panel/VBoxContainer/Magnet/MagnetUpgradeButton

@onready var coin_value_label = $Panel/VBoxContainer/CoinValueUpgrade/CoinValue
@onready var coin_value_button = $Panel/VBoxContainer/CoinValueUpgrade/CoinValueButton


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Open Shop"):
		visible = !visible
	
	speed_label.text = "Upgrade Speed (Level %d ➡️ Level %d): " % [Global.speed_level, Global.speed_level + 1]
	speed_button.text = "%d Coins" % Global.speed_cost
	
	magnet_label.text = "Upgrade Magnet Radius (Level %d ➡️ Level %d): " % [Global.magnet_level, Global.magnet_level + 1]
	magnet_button.text = "%d Coins" % Global.magnet_cost
	
	coin_value_label.text = "Upgrade Coin Value (%d Coin ➡️ %d Coin): " % [Global.coin_value, Global.coin_value + 1]
	coin_value_button.text = "%d Coins" % Global.coin_value_upgrade_cost
	

func _on_magnet_upgrade_button_pressed() -> void:
	if Global.coin >= Global.magnet_cost:
		Global.coin -= Global.magnet_cost
		Global.magnet_level += 1
		Global.speed_cost = int(Global.magnet_base_cost * pow(1.5, Global.magnet_level))
		Global.magnet_radius = Vector2((Global.magnet_radius.x + 1.0), (Global.magnet_radius.y + 1.0))
	else:
		print("Not Enough Coins")

func _on_speed_upgrade_button_pressed() -> void:
	if Global.coin >= Global.speed_cost:
		Global.coin -= Global.speed_cost
		Global.speed_level += 1
		Global.speed_cost = int(Global.speed_base_cost * pow(1.5, Global.speed_level))
		Global.speed += 20
	else:
		print("Not Enough Coins")

func _on_coin_value_button_pressed() -> void:
	if Global.coin >= Global.coin_value_upgrade_cost:
		Global.coin -= Global.coin_value_upgrade_cost
		Global.coin_value += 1
		Global.coin_value_upgrade_cost = int(Global.coin_value_upgrade_base_cost * pow(1.5, Global.coin_value))
