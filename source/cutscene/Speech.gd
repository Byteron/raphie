extends Control
class_name Speech

signal finished

export var speaker := "Speaker"

export(Array, String, MULTILINE) var lines = []

var current = -1 setget _set_current

onready var text_box = $TextBox

func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if has_next_line() and not is_writing():
			next_line()
		elif is_writing():
			complete()
		elif not has_next_line() and not is_writing():
			emit_signal("finished")

func reset():
	current = -1
	text_box.reset()

func next_line():
	current += 1
	_set_current(current)

func has_next_line():
	return current + 1 < lines.size()

func complete():
	text_box.complete()

func is_writing():
	return text_box.writing

func _set_current(value):
	current = value
	text_box.write(speaker, lines[current])