extends CanvasLayer

signal finished

var current_index := -1
var current_speech

func _input(event: InputEvent) -> void:
	if current_speech:
		current_speech.input(event)

func add_speech(res: RSpeech) -> void:
	var speech := Instance.Speech()
	speech.speaker = res.speaker
	speech.lines = res.lines
	speech.connect("finished", self, "_on_Speech_finished")
	add_child(speech)

func start():
#	print("start speech")
	_on_Speech_finished()

func _on_Speech_finished() -> void:
	if current_speech:
		current_speech.hide()

	current_index += 1

#	print("Index: ", current_index, " Child Count: ", get_child_count())
	if current_index == get_child_count():
#		print("end of dialoque")
		set_process_input(false)
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("finished")
		current_speech = null
	else:
#		print("next speech")
		current_speech = get_child(current_index)
		current_speech.show()
		current_speech.next_line()
