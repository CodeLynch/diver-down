extends CharacterBody2D

@export var chest_value = 1000
signal got_chest(value: int)

func _on_contact_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("diver"):
		got_chest.emit(chest_value)
		visible = false
		queue_free()
