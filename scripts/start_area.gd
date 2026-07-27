extends Node2D

@onready var diver = $"../Diver"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("diver"):
		if diver.cleared_debt:
			get_tree().change_scene_to_file("res://scenes/win_scene.tscn")
