extends Control

var key = null
var action = ""

onready var anim := $AnimationPlayer as AnimationPlayer

func shows_key() -> bool:
	return true if key else false

func new_key(action: String) -> void:

	if key:
		clear()
		yield(anim, "animation_finished")

	self.action = action

	key = Instance.KeyButton()
	key.text = Controller.get_key_string(action)

	add_child(key)

	anim.play("fade_in")

func update_key() -> void:
#	print("update_key")
	if action and key:
#		print("updated key ", Controller.get_key_string(action))
		key.text = Controller.get_key_string(action)

func clear() -> void:
	action = ""
	anim.play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:

	if anim_name == "fade_in":
		anim.play("press")

	if anim_name == "fade_out":
		if key:
			key.queue_free()
			key = null
