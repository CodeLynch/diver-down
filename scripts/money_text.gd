extends RichTextLabel

@export var duration = .3
var tween

func tween_update(new_value: int) -> void:
	var current_value = int(text.replace("$", "").strip_edges())
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(update_text_value, current_value, new_value, duration)

func update_text_value(value: int) -> void:
	text = "$ {money}".format({"money": value})
