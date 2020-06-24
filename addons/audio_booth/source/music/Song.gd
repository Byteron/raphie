extends Node

signal finished()

signal bar()
signal beat()

var pitch_scale := 1.0 setget _set_pitch_scale
var volume_db := 1.0 setget _set_volume_db

var time := 0.0

var beats_per_second := 0.0

var beat2bar := 0.0

var current_beat := 0
var last_beat := -1

var current_bar:= 0

export var tempo := 0.0
export var beats := 0

onready var players := []
onready var core : AudioStreamPlayer = null
onready var tween := Tween.new()

func _ready() -> void:
	set_process(false)

	players = get_children()
	core = get_child(0)
	beats_per_second = 60.0 / tempo

	tween.connect("tween_completed", self, "_on_Tween_tween_completed")
	tween.name = "Tween"
	add_child(tween)

func _process(delta: float) -> void:

	time = core.get_playback_position()

	current_beat = 1 + int(time / beats_per_second)

	if current_beat != last_beat:
		emit_signal("beat")

		if current_beat % beats == 0:
			emit_signal("bar")

		last_beat = current_beat

func play_core() -> void:
	core.play()

func play(fade_time := 0.0) -> void:

	for player in players:
		player.play()

func stop(fade_time := 0.0) -> void:

	for player in players:
		player.stop()

func play_layer(layer: int, fade_time := 0.0) -> void:

	if players.size() < layer:
		return

	var player = players[layer]

	if fade_time:
		_fade_in(player, fade_time)

	player.play()

func stop_layer(layer: int, fade_time := 0.0) -> void:
	var player = players[layer]

	if fade_time:
		_fade_out(player, fade_time)
	else:
		player.stop()

func _set_pitch_scale(value) -> void:
	pitch_scale = value

	for player in players:
		player.pitch_scale = value

func _set_volume_db(value) -> void:
	volume_db = value

	for player in players:
		player.volume_db = value

func _fade_in(player: AudioStreamPlayer, fade_time: float) -> void:
	tween.interpolate_property(player, "volume_db", -60.0, volume_db, fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _fade_out(player: AudioStreamPlayer, fade_time: float) -> void:
	tween.interpolate_property(player, "volume_db", volume_db, -60.0, fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:

	if object is AudioStreamPlayer and object.volume_db == -60.0:
		object.stop()
