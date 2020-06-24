extends StaticBody2D

signal opened()
signal closed()

signal locked()
signal unlocked()

var closed := true

export var locked := false
export var automatic := false

onready var close_timer := $CloseTimer as Timer

onready var coll := $CollisionShape2D as CollisionShape2D
onready var sprite := $Sprite as Sprite

onready var anim := $AnimationPlayer as AnimationPlayer

onready var enter_area := $EnterArea as Area2D

func lock() -> void:
	locked = true
	emit_signal("locked")

func unlock() -> void:
	locked = false
	emit_signal("unlocked")

func open() -> void:
	if locked or not closed:
		return

	if automatic and close_timer.is_stopped():
		close_timer.start()

	closed = false
	anim.play("open")
	emit_signal("opened")

func close() -> void:

	if closed:
		return

	if not close_timer.is_stopped():
		close_timer.stop()

	closed = true
	anim.play_backwards("open")
	emit_signal("closed")

func _on_EnterArea_body_entered(body) -> void:
	if automatic:
		open()

func _on_CloseTimer_timeout() -> void:
	close()