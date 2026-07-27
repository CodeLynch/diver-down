extends Area2D

signal player_entered()
signal player_exit()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("diver"):
		player_entered.emit()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("diver"):
		player_exit.emit()
