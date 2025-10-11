extends HBoxContainer

@onready var G = Global

@onready var auto_collect_label = $AutoCollect
@onready var auto_collect_button = $AutoCollectUnlock



func _on_auto_collect_unlock_pressed() -> void:
	if G.coin >= G.auto_collect_price:
		G.coin -= G.auto_collect_price
		auto_collect_button.disabled = true
		G.auto_collect_purchase = true
		auto_collect_button.text = "(Purchased)"
