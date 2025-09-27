extends CharacterBody2D

var speed 

func _physics_process(_delta: float) -> void:
	speed = Global.speed
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	position.x = clamp(position.x, 20, (screen_size.x - 20))
	position.y = clamp(position.y, 85, (screen_size.y - 20))
