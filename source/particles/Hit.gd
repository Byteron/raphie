extends Sprite

onready var anim := $AnimationPlayer as AnimationPlayer

func play() -> void:
	randomize()
	anim.play(["hit1", "hit2"][randi() % 2])

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()