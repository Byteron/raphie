extends Sprite

enum VERSION { V1, V2, V3 }

export(VERSION) var version = VERSION.V1

func _ready() -> void:
	frame = version

