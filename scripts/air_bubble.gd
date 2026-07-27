extends Node2D

@export var regen_amount = 30
signal increase_tank(amount: int) 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("diver"):
		increase_tank.emit(30)
		visible = false
		await get_tree().create_timer(.5).timeout
		queue_free()
