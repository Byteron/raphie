extends Panel

onready var master_selector := $CenterContainer/VBoxContainer/Sound/Master
onready var music_selector := $CenterContainer/VBoxContainer/Sound/Music
onready var effects_selector := $CenterContainer/VBoxContainer/Sound/Effects

onready var back_button := $CenterContainer/VBoxContainer/Back as Button

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		back_button._pressed()
		back_button.emit_signal("pressed")

func _ready() -> void:
	Glitch.level = 1
	master_selector.volume = Audio.linear2int(Audio.master_volume)
	music_selector.volume = Audio.linear2int(Audio.music_volume)
	effects_selector.volume = Audio.linear2int(Audio.effects_volume)

func _on_Back_pressed() -> void:
	Scene.change(Scene.TitleScreen)

func _on_Master_volume_changed(volume) -> void:
	Audio.master_volume = Audio.int2linear(volume)

func _on_Music_volume_changed(volume) -> void:
	Audio.music_volume = Audio.int2linear(volume)

func _on_Effects_volume_changed(volume) -> void:
	Audio.effects_volume = Audio.int2linear(volume)
