extends Sprite

onready var anim := $AnimationPlayer as AnimationPlayer

func alert() -> void:
	anim.play("alert")

func normal() -> void:
	anim.play("normal")