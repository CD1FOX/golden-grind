extends HBoxContainer

@onready var G = Global

@onready var magnet_label = $Magnet
@onready var magnet_button = $MagnetButton

func update_label(magnet_level, magnet_cost):
	magnet_label.text = "Upgrade Magnet Skill (Level %d ➡️ Level %d): " % [magnet_level, magnet_level + 1]
	magnet_button.text = "%d Coins" % magnet_cost

func _ready() -> void:
	update_label(G.magnet_level, G.magnet_cost)

func _on_magnet_button_pressed() -> void:
	if G.coin >= G.magnet_cost:
		G.coin -= G.magnet_cost
		G.magnet_level += 1
		G.magnet_cost = int(G.magnet_base_cost * pow(1.5, G.magnet_level))
		G.magnet_radius = Vector2((G.magnet_radius.x + 1.0), (G.magnet_radius.y + 1.0))
	else:
		print("Not Enough Coins")
	
	update_label(G.magnet_level, G.magnet_cost)
	
