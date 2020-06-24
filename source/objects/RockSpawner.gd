extends Node

func spawn_rocks(origin: Vector2, extents: int, count: int) -> void:
	for i in count:
		var rock = Instance.Rock()
		get_tree().current_scene.add_child(rock)
		rock.global_position = origin + Vector2(rand_range(-extents, extents), -400)
		yield(get_tree().create_timer(0.35), "timeout")