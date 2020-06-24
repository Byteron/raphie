extends Node
class_name ScreenShake

var amplitude := 0.0
var priority := 0

onready var tween := $Tween as Tween

onready var frequency_timer = $Frequency as Timer
onready var duration_timer = $Duration as Timer

onready var camera := get_parent() as Camera2D

func start(duration: float = 0.5, frequency: float = 15.0, amplitude: float = 16.0, priority: int = 0) -> void:

	if priority < self.priority:
		return

	self.amplitude = amplitude
	self.priority = priority

	duration_timer.wait_time = duration
	frequency_timer.wait_time = 1.0 / frequency

	duration_timer.start()
	frequency_timer.start()

func _new_shake() -> void:
	var rand := Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	tween.interpolate_property(camera, "offset", camera.offset, rand, frequency_timer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _reset() -> void:
	tween.interpolate_property(camera, "offset", camera.offset, Vector2(), frequency_timer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	priority = 0

func _on_Frequency_timeout() -> void:
	_new_shake()

func _on_Duration_timeout() -> void:
	_reset()
	frequency_timer.stop()
