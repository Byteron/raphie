extends Sprite

onready var anim := $AnimationPlayer

func play(anim_name: String, flipped := false) -> void:
	flip_h = flipped
	anim.play(anim_name)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()