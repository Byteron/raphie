extends TextureProgress

func reset() -> void:
	value = max_value

func set_max_health(new_max_health) -> void:
	max_value = new_max_health

func update_health(new_health: int) -> void:
	value = new_health