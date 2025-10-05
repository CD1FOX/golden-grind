extends CharacterBody2D

var speed 
var magnet_radius

@onready var magnet_radius_area = $Magnet/CollisionShape2D

func _physics_process(_delta: float) -> void:
	if Global.auto_collect:
		var target = get_nearest_coin()
		if target:
			position = position.move_toward(target.global_position, speed * _delta)
	
	speed = Global.speed
	magnet_radius = Global.magnet_radius
	magnet_radius_area.scale = magnet_radius
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	position.x = clamp(position.x, 20, (screen_size.x - 20))
	position.y = clamp(position.y, 85, (screen_size.y - 20))


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		Global.coin += Global.coin_value
		area.queue_free()
		

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
