extends Control

@onready var speed_label = $Panel/GridContainer/Speed
@onready var speed_button = $Panel/GridContainer/UpgradeButton

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Open Shop"):
		visible = !visible
	
	speed_label.text = "Upgrade Speed (Level %d ➡️ Level %d): " % [Global.speed_level, Global.speed_level + 1]
	speed_button.text = "%d Coins" % Global.speed_cost
	

func _on_upgrade_button_pressed() -> void:
	if Global.coin >= Global.speed_cost:
		Global.coin -= Global.speed_cost
		Global.speed_level += 1
		Global.speed_cost = int(Global.speed_base_cost * pow(1.5, Global.speed_level))
		Global.speed += 20
	else:
		print("Not Enough Coins")
