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
