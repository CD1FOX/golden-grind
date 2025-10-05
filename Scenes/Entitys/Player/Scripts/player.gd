extends CharacterBody2D

@onready var G = Global

func _physics_process(_delta: float) -> void:
	if Global.auto_collect:
		var target = get_nearest_coin()
		if target:
			position = position.move_toward(target.global_position, G.speed * _delta)

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * G.speed
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	position.x = clamp(position.x, 20, (screen_size.x - 20))
	position.y = clamp(position.y, 85, (screen_size.y - 20))

func get_nearest_coin():
	var nearest_area = null
	var nearest_distance = INF
	
	for area in get_tree().get_nodes_in_group("coin"):
		if area and area.is_inside_tree():
			var distance = global_position.distance_to(area.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_area = area
		
	return nearest_area
