extends Area2D

@onready var G = Global
@onready var magnet_radius_collider = $MagnetRadius

func _physics_process(_delta: float) -> void:
	if not G.magnet_skill:
		magnet_radius_collider.disabled = true
		return
	else:
		magnet_radius_collider.disabled = false
		magnet_radius_collider.scale = G.magnet_radius
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		G.multiplier_distributer(area)
