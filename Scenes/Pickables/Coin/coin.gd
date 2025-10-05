extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.multiplier_distributer(self)

func _on_timer_timeout() -> void:
	queue_free()
