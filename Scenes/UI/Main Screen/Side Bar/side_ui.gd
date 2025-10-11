extends Control

@onready var show_hide_button = $VisibilityButton
@onready var background_UI = $Panel
@onready var G = Global

@onready var auto_collect_toggle = $Panel/VBoxContainer/AutoCollect
@onready var magnet_toggle = $Panel/VBoxContainer/Magnet

func _process(_delta: float) -> void:
	if not G.auto_collect_purchase:
		auto_collect_toggle.disabled = true
	else:
		auto_collect_toggle.disabled = false
	
	if not G.magnet_purchase:
		magnet_toggle.disabled = true
	else:
		magnet_toggle.disabled = false

func _on_visibility_button_toggled(toggled_on: bool) -> void:
	background_UI.visible = !background_UI.visible
	if toggled_on:
		show_hide_button.position = Vector2(1122.0, 105.0)
		show_hide_button.text = "<"
	else:
		show_hide_button.position = Vector2(972.0, 105.0)
		show_hide_button.text = ">"

func _on_auto_collect_pressed() -> void:
	G.auto_collect = !G.auto_collect

func _on_magnet_pressed() -> void:
	G.magnet_skill = !G.magnet_skill
