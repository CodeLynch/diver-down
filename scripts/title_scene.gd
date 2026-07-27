extends Node2D
@onready var bg_music = $BGMusic
var bg_music_on = true

func _ready() -> void:
	update_music()
	
func update_music() -> void:
	if bg_music_on:
		if !bg_music.playing:
			bg_music.play()
	else:
		bg_music.stop()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn") 
