extends Control

@onready var coin_label = $Coins
@onready var speed_label = $Speed
@onready var zone_level = $Zone
@onready var shop_popup = $ShopPopup
@onready var confirmation_dialog = $BuyZone/ConfirmationDialog
@onready var accept_dialog = $BuyZone/AcceptDialog

@onready var G = Global

func _process(_delta: float) -> void: 
	coin_label.text = "Coins: %d" % G.coin
	speed_label.text = "Speed: %d" % G.speed
	zone_level.text = "Zone: %d" % G.current_zone_level
	confirmation_dialog.dialog_text = "Buy new zone for %d Coins?" % G.zone_price

func _on_shop_pressed() -> void:
	shop_popup.visible = !shop_popup.visible

func _on_buy_zone_pressed() -> void:
	confirmation_dialog.visible = true

func _on_confirmation_dialog_confirmed() -> void:
	if G.coin >= G.zone_price:
		G.coin -= G.zone_price
		G.zone_price *= 4
		G.current_zone_level += 1
	
		if G.current_zone_level != G.last_zone_level:
			# figure out which folder the zone belongs to
			var group_size = 10
			var start = int(floor((G.current_zone_level - 1) / group_size) * group_size + 1)
			var end = start + group_size - 1
			
			var folder = "Zone %d - %d" % [start, end]
			var scene_path = "res://Scenes/Worlds/%s/zone%d.tscn" % [folder, G.current_zone_level]
			
			if ResourceLoader.exists(scene_path):
				get_tree().change_scene_to_file(scene_path)
			else:
				push_error("Scene does not exist: " + scene_path)
	else:
		accept_dialog.dialog_text = "Not enough coins! (need %d coins more)" % (G.coin - G.zone_price)
		accept_dialog.visible = true
