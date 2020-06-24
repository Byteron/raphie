extends NinePatchRect

const masks = [
	preload("res://graphics/images/misc/displacement.png"),
	preload("res://graphics/images/misc/displacement2.png"),
	preload("res://graphics/images/misc/displacement3.png"),
]

var level := 1.0 setget _set_level

var offset := 0.0 setget _set_offset
var abberation := 0.0 setget _set_abberation

export var wait_time_from := 3.0
export var wait_time_to := 6.0

onready var wait = $Wait as Timer
onready var glitch = $Glitch as Timer
onready var abberation_timer := $Abberation as Timer

func _ready() -> void:
	_set_abberation(0.001 * level)
	wait.wait_time = _new_time()
	wait.start()

func _new_time() -> float:
	randomize()
	return rand_range(wait_time_from / level, wait_time_to / level)

func _set_level(value) -> void:
	level = value
	_set_abberation(0.001 * level)

	if level == 0:
		wait.stop()
		glitch.stop()
		abberation_timer.stop()
		_set_offset(0.0)
		_set_abberation(0.000)
	else:
		wait.wait_time = _new_time()
		wait.start()

func _set_offset(value) -> void:
	offset = value
	material.set_shader_param("offset", offset)
	_set_abberation(rand_range(0.001 * level, offset))

func _set_abberation(value) -> void:
	abberation = value
	material.set_shader_param("abberation", abberation)

func _on_Timer_timeout() -> void:
	_set_offset(_rand(0.0, 0.01))
	Audio.play_sfx("glitch")
	glitch.wait_time = _rand(0.01, 0.2)
	glitch.start()
	abberation_timer.start()

func _on_Glitch_timeout() -> void:
	abberation_timer.stop()
	_set_offset(0.0)
	_set_abberation(0.001)
	wait.wait_time = _new_time()
	wait.start()

func _rand(from: float, to: float) -> float:
	randomize()
	return rand_range(from * level, to * level)

func _on_Mask_timeout() -> void:
	material.set_shader_param("mask", masks[randi() % masks.size()])

func _on_Abberation_timeout() -> void:
	_set_abberation(rand_range(0.001 * level, offset))
