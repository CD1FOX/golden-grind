extends Control

@onready var coin_label = $Coins
@onready var speed_label = $Speed
@onready var speed_level_label = $SpeedLevel
@onready var zone_level = $Zone
@onready var shop_popup = $ShopPopup
@onready var confirmation_dialog = $BuyZone/ConfirmationDialog
@onready var accept_dialog = $BuyZone/AcceptDialog

func _process(_delta: float) -> void: 
	coin_label.text = "Coins: %d" % Global.coin
	speed_label.text = "Speed: %d" % Global.speed
	speed_level_label.text = "Speed Level: %d" % Global.speed_level
	zone_level.text = "Zone: %d" % Global.current_zone_level
	confirmation_dialog.dialog_text = "Buy new zone for %d Coins?" % Global.zone_price

func _on_shop_pressed() -> void:
	shop_popup.visible = !shop_popup.visible

func _on_buy_zone_pressed() -> void:
	confirmation_dialog.visible = true

func _on_confirmation_dialog_confirmed() -> void:
	if Global.coin >= Global.zone_price:
		Global.coin -= Global.zone_price
		Global.zone_price *= 4
		Global.current_zone_level += 1
	
		if Global.current_zone_level != Global.last_zone_level:
			# figure out which folder the zone belongs to
			var group_size = 10
			@warning_ignore("integer_division")
			var start = int(floor((Global.current_zone_level - 1) / group_size) * group_size + 1)
			var end = start + group_size - 1
			
			var folder = "Zone %d - %d" % [start, end]
			var scene_path = "res://Scenes/Worlds/%s/zone%d.tscn" % [folder, Global.current_zone_level]
			
			if ResourceLoader.exists(scene_path):
				get_tree().change_scene_to_file(scene_path)
			else:
				push_error("Scene does not exist: " + scene_path)
	else:
		accept_dialog.dialog_text = "Not enough coins! (need %d coins more)" % (Global.coin - Global.zone_price)
		accept_dialog.visible = true
