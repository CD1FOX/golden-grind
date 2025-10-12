extends Control

@onready var show_hide_button = $VisibilityButton
@onready var background_UI = $Panel
@onready var G = Global

@onready var magnet_toggle = $Panel/VBoxContainer/Magnet
@onready var auto_collect_toggle = $Panel/VBoxContainer/AutoCollect

var tween

func _process(_delta: float) -> void:
	if not G.auto_collect_purchase:
		auto_collect_toggle.disabled = true
	else:
		auto_collect_toggle.disabled = false
	
	if not G.magnet_purchase:
		magnet_toggle.disabled = true
	else:
		magnet_toggle.disabled = false

func side_bar_animate(background_pos_x, button_pos_x, text):
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(show_hide_button, "position", Vector2(button_pos_x, 105), .5)
	tween.parallel().tween_property(background_UI, "position", Vector2(background_pos_x, 105), .5)
	show_hide_button.text = text

func _on_visibility_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		side_bar_animate(1152.0 ,1122.0, "<")
	else:
		side_bar_animate(1002.0 ,972.0, ">")

func _on_auto_collect_pressed() -> void:
	G.auto_collect = !G.auto_collect

func _on_magnet_pressed() -> void:
	G.magnet_skill = !G.magnet_skill
