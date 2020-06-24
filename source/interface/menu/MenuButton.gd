extends Button

export var grab_focus := false

func _ready() -> void:
	if grab_focus:
		grab_focus()

func _pressed() -> void:
	Audio.play_sfx("button_pressed")

func _on_MenuButton_mouse_entered() -> void:
	Audio.play_sfx("button_hover")
	grab_focus()

func _on_MenuButton_focus_entered() -> void:
	if grab_focus:
		grab_focus = false
	else:
		Audio.play_sfx("button_hover")
