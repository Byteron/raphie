extends Control

func _ready() -> void:
	Audio.stop_song()
	Glitch.level = 4

func _on_Retry_pressed() -> void:
#	print(Scene.prev_scene)

	if Scene.prev_scene:
		Scene.change(Scene.prev_scene)

func _on_Quit_pressed() -> void:
	Scene.change(Scene.TitleScreen)
