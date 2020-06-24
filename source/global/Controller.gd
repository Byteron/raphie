extends Node

signal device_changed()

enum DEVICES { KEYBOARD, GAMEPAD }

var input_map := {
	ui_left = ["<", "<"],
	ui_right = [">", ">"],
	ui_up = ["^", "^"],
	ui_down = ["v", "v"],
	jump = ["_", "A"],
	attack = ["B", "R/R1"],
	shoot = ["V", "L/L1"],
	dash = ["C", "B"],
	special = ["X", "Y"]
}

var current_device: int = DEVICES.KEYBOARD

func _input(event: InputEvent) -> void:

	if current_device == DEVICES.KEYBOARD:

		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			current_device = DEVICES.GAMEPAD
			emit_signal("device_changed")

	elif current_device == DEVICES.GAMEPAD:

		if not event is InputEventJoypadButton and not event is InputEventJoypadMotion:
			current_device = DEVICES.KEYBOARD
			emit_signal("device_changed")

func get_key_string(action: String) -> String:
	return input_map[action][current_device]