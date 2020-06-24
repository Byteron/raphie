extends Area2D

signal reached(id)

var active := false

var id := 0

onready var anim := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	id = get_index()

func _on_Checkpoint_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Player and not active:
		active = true
		anim.play("activate")
		emit_signal("reached", id)
		Audio.play_sfx("checkpoint")
