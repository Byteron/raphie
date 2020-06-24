extends Sprite

onready var anim := $AnimationPlayer as AnimationPlayer

func open() -> void:
	anim.play("open")