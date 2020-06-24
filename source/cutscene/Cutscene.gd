extends Event
class_name Cutscene, "res://graphics/images/icons/cutscene.png"

signal started
signal finished

export(Array, Resource) var speeches = []

onready var dialoque := $Dialoque

func _ready() -> void:
	_setup_speeches()

func _happen() -> void:
	if not requirements_fullfilled():
		return

	if delay:
		delay_timer.start(delay)
		yield(delay_timer, "timeout")

	emit_signal("started")
	dialoque.start()

func _setup_speeches() -> void:
	for res in speeches:
		dialoque.add_speech(res)

func _on_Dialoque_finished() -> void:
	_set_on_enter(false)
	happened = true
	emit_signal("happened")
	emit_signal("seen", id)
	emit_signal("finished")
