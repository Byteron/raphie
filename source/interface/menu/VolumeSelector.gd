extends Control

enum BUS { MASTER, MUSIC, EFFECTS }

var volume := 10 setget _set_volume

export var grab_focus := false

export(BUS) var bus := BUS.MASTER
export var title := "Music"

onready var tween := $Tween as Tween

onready var highlighter := $ColorRect as ColorRect

onready var title_label := $CenterContainer/HBoxContainer/Title as Label
onready var volume_label := $CenterContainer/HBoxContainer/Volume

onready var left_button := $CenterContainer/HBoxContainer/LeftButton as TextureButton
onready var right_button := $CenterContainer/HBoxContainer/RightButton as TextureButton

signal volume_changed(volume)

func _input(event: InputEvent) -> void:

	if has_focus():

		if event.is_action_pressed("ui_left"):
			left_button.emit_signal("pressed")
		elif event.is_action_pressed("ui_right"):
			right_button.emit_signal("pressed")

func _ready() -> void:

	if grab_focus:
		grab_focus()

	title_label.text = title

func _set_volume(value) -> void:
	volume = clamp(value, 0, 10)
	volume_label.text = str(volume)
	emit_signal("volume_changed", volume)

func _increase() -> void:
	_set_volume(volume + 1)

func _decrease() -> void:
	_set_volume(volume - 1)

func _on_LeftButton_pressed() -> void:
	_decrease()
	Audio.play_sfx("button_hover")

func _on_RightButton_pressed() -> void:
	_increase()
	Audio.play_sfx("button_hover")

func _on_VolumeSelector_focus_entered() -> void:
	tween.stop_all()
	tween.interpolate_property(highlighter, "modulate:a", highlighter.modulate.a, 0.2, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	Audio.play_sfx("button_hover")

func _on_VolumeSelector_focus_exited() -> void:
	tween.stop_all()
	tween.interpolate_property(highlighter, "modulate:a", highlighter.modulate.a, 0, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
