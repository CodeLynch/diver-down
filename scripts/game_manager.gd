extends Control
@onready var fade_panel = $"../UI/FadePanel"
@onready var diver = $"../../Diver"
@onready var restart_button = $"../UI/FadePanel/RestartButton"

func _ready() -> void:
	diver.connect("end_game", game_over)
	
func game_over() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_panel, "modulate:a", 1, .5)
	restart_button.disabled = false
	
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
