extends HBoxContainer

@onready var G = Global

@onready var speed_label = $Speed
@onready var speed_button = $SpeedButton

func update_label(speed_level, speed_cost):
	speed_label.text = "Upgrade Movement Speed (Level %d ➡️ Level %d): " % [speed_level, speed_level + 1]
	speed_button.text = "%d Coins" % speed_cost

func _ready() -> void:
	update_label(G.speed_level, G.speed_cost)

func _on_speed_button_pressed() -> void:
	if G.coin >= G.speed_cost:
		G.coin -= G.speed_cost
		G.speed_level += 1
		G.speed += 20
		G.speed_cost = int(G.speed_base_cost * pow(1.5, G.speed_level))
	else:
		print("Not Enough Coins")
	
	update_label(G.speed_level, G.speed_cost)
