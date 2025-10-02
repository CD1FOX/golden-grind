extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.coin += Global.coin_value
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
