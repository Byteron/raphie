extends Panel

onready var load_button := $CenterContainer/VBoxContainer/Buttons/Load as Button

func _ready() -> void:
	Audio.play_song("MenuLoop")
	Glitch.level = 1

	if GameSaver.current_level:
		load_button.visible = true
		load_button.grab_focus()

func _on_Play_pressed() -> void:
	GameSaver.delete()
	Scene.change(Scene.Level[1])

func _on_Credits_pressed() -> void:
	Scene.change(Scene.Credits)

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Load_pressed() -> void:
	Scene.change(Scene.Level[GameSaver.current_level])

func _on_Settings_pressed() -> void:
	Scene.change(Scene.Settings)
