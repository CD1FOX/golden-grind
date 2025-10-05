extends Node

@onready var player = $"../.."
@onready var G = Global

func _process(delta: float) -> void:
	if G.auto_collect:
		var target = get_nearest_coin()
		if target:
			player.position = player.position.move_toward(target.global_position, G.speed * delta)

func get_nearest_coin():
	var nearest_area = null
	var nearest_distance = INF
	
	for area in get_tree().get_nodes_in_group("coin"):
		if area and area.is_inside_tree():
			var distance = player.position.distance_to(area.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_area = area
	return nearest_area
