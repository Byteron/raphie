extends Node

var active := false

var time_scale := 1.0

export var slow_down_scale := 0.3
export var slow_down_time := 0.4

onready var tween := $Tween as Tween

func hit() -> void:
	tween.interpolate_property(self, "time_scale", 0, time_scale, 0.1, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

func toggle() -> bool:

	if tween.is_active():
		return false

	if active:
		tween.interpolate_property(self, "time_scale", Engine.time_scale, 1.0, slow_down_time, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()
		active = false
	else:
		tween.interpolate_property(self, "time_scale", Engine.time_scale, slow_down_scale, slow_down_time, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()
		active = true

	return true

func _on_Tween_tween_step(object: Object, key: NodePath, elapsed: float, value) -> void:
	Engine.time_scale = value
	var pitch_effect = AudioServer.get_bus_effect(2, 0)
	pitch_effect.pitch_scale = value
