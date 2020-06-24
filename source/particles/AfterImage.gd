extends Node2D

var mat = preload("res://graphics/materials/after_image.tres")

onready var tween := $Tween as Tween
onready var sprite := $Sprite as Sprite

var fade := 0.0

func _ready() -> void:
	sprite.material = mat.duplicate(true)

func play(flipped := false) -> void:

	sprite.flip_h = flipped

	tween.interpolate_property(self, "fade", 0.0, 1.0, 1.6, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()

func _on_Tween_tween_step(object: Object, key: NodePath, elapsed: float, value) -> void:
	sprite.material.set_shader_param("offset", value)
