extends Node

enum PLAYMODES { PLAY, LOOP, SHUFFLE }

signal song_changed(song_name)

signal beat()
signal bar()

var play_on_beat_queue := []
var play_on_bar_queue := []

var stop_on_beat_queue := []
var stop_on_bar_queue := []

var current_song : Node = null

var next_song_data := {}

export(PLAYMODES) var play_mode := PLAYMODES.PLAY

onready var songs := {}

func _ready() -> void:

	for song in get_children():
		song.connect("beat", self, "_on_beat")
		song.connect("bar", self, "_on_bar")
		songs[song.name] = song

func play_song(song_name: String, delay := 0) -> void:

	if is_playing():
		next_song_data = { "name": song_name, "delay": delay }
		return

	current_song = _get_song(song_name)

	current_song.play_core()
	current_song.set_process(true)

func play_layer(layer: int, fade_time := 0.0) -> void:

	if not is_playing():
		return

	current_song.play_layer(layer, fade_time)

func play_layer_on_beat(layer: int, fade_time := 0.0, delay := 0) -> void:
	play_on_beat_queue.append({ "layer": layer, "fade_time": fade_time, "delay": delay })

func play_layer_on_bar(layer: int, fade_time := 0.0, delay := 0) -> void:
	play_on_bar_queue.append({ "layer": layer, "fade_time": fade_time, "delay": delay })

func stop_song() -> void:

	if not is_playing():
		return

	current_song.stop()
	current_song = null

func stop_layer(layer: int, fade_time := 0.0) -> void:
#	print("Stop Layer: ", layer, ", Fade Out: ", fade_time)

	if not is_playing():
		return

	current_song.stop_layer(layer, fade_time)

func stop_layer_on_beat(layer: int, fade_time := 0.0, delay := 0) -> void:
	stop_on_beat_queue.append({ "layer": layer, "fade_time": fade_time, "delay": delay })

func stop_layer_on_bar(layer: int, fade_time := 0.0, delay := 0) -> void:
	stop_on_bar_queue.append({ "layer": layer, "fade_time": fade_time, "delay": delay })

func is_playing() -> bool:
	return current_song != null

func is_song_playing(song_name: String) -> bool:

	if not current_song:
		return false

	return current_song.name == song_name

func _get_song(song_name: String) -> Node:
	assert(songs.has(song_name))
	return songs[song_name]

func _next_song() -> void:
#	print("Song Changed To: ", next_song_data.name)

	current_song.set_process(false)
	current_song.stop()
	current_song = _get_song(next_song_data.name)

	current_song.play_core()

	current_song.set_process(true)

	emit_signal("song_changed", next_song_data.name)

	next_song_data = {}

func _iterate_layer_container(container: Array, action: String) -> void:
	var done := []

	for layer_data in container:

		if layer_data.delay == 0:
#			print(layer_data)

			match action:
				"play": play_layer(layer_data.layer, layer_data.fade_time)
				"stop": stop_layer(layer_data.layer, layer_data.fade_time)

			done.append(layer_data)
		else:
			layer_data.delay -= 1

	for layer_data in done:
		container.erase(layer_data)

func _on_beat() -> void:
#	print("beat")

	_iterate_layer_container(play_on_beat_queue, "play")
	_iterate_layer_container(stop_on_beat_queue, "stop")

	emit_signal("beat")

func _on_bar() -> void:
#	print("bar")

	if next_song_data:
#		print(next_song_data)
		if next_song_data.delay == 0:
			_next_song()
		else:
			next_song_data.delay -= 1

	_iterate_layer_container(play_on_bar_queue, "play")
	_iterate_layer_container(stop_on_bar_queue, "stop")

	emit_signal("bar")
