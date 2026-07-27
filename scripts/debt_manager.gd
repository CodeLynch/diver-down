extends Control

@onready var chest_manager = $"../../../ChestsManager"
@onready var money_text = $MoneyText
@onready var goal_text = $GoalText

signal diver_cleared_debt()

func _ready() -> void:
	chest_manager.connect("update_money", update_text)
	
func update_text(money: float):
	var current_money = money_text.text.replace("$", "").strip_edges() 
	var new_value = int(current_money) + money
	money_text.tween_update(new_value)
	if new_value >= 1000000000:
		goal_text.text = "Goal Reached! Get Back to the Start Point!"
		diver_cleared_debt.emit()
