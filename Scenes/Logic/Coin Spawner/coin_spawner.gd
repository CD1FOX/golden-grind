extends Node2D

@onready var coin_scene = preload("res://Scenes/Pickables/Coin/coin.tscn")

var min_distance = 50.0
var max_tries = 10


func _on_coin_spawner_timer_timeout() -> void:
	var spawn_pos
	var valid
	
	for i in range(max_tries):
		spawn_pos = Vector2(
			randf_range(15, 1137),
			randf_range(80, 633)
		)
		if is_position_valid(spawn_pos):
			valid = true
			break
	
	if valid:
		var coin = coin_scene.instantiate()
		coin.position = spawn_pos
		coin.add_to_group("coin")
		get_parent().add_child(coin)
	else:
		print("⚠ No valid position found after", max_tries, "tries")

func is_position_valid(pos: Vector2):
	for child in get_children():
		if child is Area2D:
			if pos.distance_to(child.position) < min_distance:
				return false
	return true
