extends Panel

onready var back_button := $CenterContainer/VBoxContainer/Buttons/Back as Button

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		back_button._pressed()
		back_button.emit_signal("pressed")

func _ready() -> void:
	Glitch.level = 1

func _on_Back_pressed() -> void:
	Scene.change(Scene.TitleScreen)
