extends Node2D

@export var bubbles:Array[NodePath] = []
@onready var pop_sfx = $AspPop

signal update_o2(amount: float)

func _ready() -> void:
	if bubbles.size() > 0:
		for bubble in bubbles:
			var bubble_node = get_node(bubble)
			bubble_node.connect("increase_tank", on_got_bubble)


func on_got_bubble(amount: int) -> void:
	pop_sfx.play()
	update_o2.emit(amount)
	
