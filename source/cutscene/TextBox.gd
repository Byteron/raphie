extends Control

var writing = false

export(int) var speed = 35

var visible_characters = 0.0

var tick := 0.0

onready var speaker_label := $MarginContainer1/Panel/MarginContainer/Label
onready var text_label = $MarginContainer2/Panel/MarginContainer/RichTextLabel

func _process(delta):
	if is_complete():
		writing = false
	elif writing:

		visible_characters += speed * delta
		text_label.visible_characters = visible_characters

		tick += delta
		if tick > 0.08:
			tick = 0.0
			Audio.play_sfx("type")

func write(speaker: String, line: String) -> void:
	speaker_label.text = speaker
	text_label.text = line
	reset()
	writing = true
	# print("start writing textbox")

func stop():
	writing = false

func reset():
	visible_characters = 0.0
	text_label.visible_characters = 0
	# print("reset textbox")

func complete():
	text_label.visible_characters = len(text_label.text)
	# print("complete textbox")

func is_complete():
	return text_label.visible_characters >= len(text_label.text)
	# print("textbox is complete")