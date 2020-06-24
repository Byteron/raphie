extends CanvasLayer

export var level := 1.0 setget _set_level

onready var tween := $Tween as Tween
onready var glitch := $Glitch

func _set_level(value):
	level = value
	glitch.level = level

func infect(time: float) -> void:
	_set_level(15)
	tween.interpolate_property(self, "level", 8, 6, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, time)
	tween.interpolate_property(self, "level", 6, 4, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, time + 1.0)
	tween.interpolate_property(self, "level", 4, 2, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, time + 2.0)
	tween.start()
