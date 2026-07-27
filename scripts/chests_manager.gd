extends Node2D

@export var chests:Array[NodePath] = []
@onready var kaching_sfx = $ASPKaching

signal update_money(money: float)

func _ready() -> void:
	if chests.size() > 0:
		for chest in chests:
			var chestNode = get_node(chest)
			chestNode.connect("got_chest", on_got_chest)


func on_got_chest(chest_value: float) -> void:
	kaching_sfx.play()
	update_money.emit(chest_value)
	
