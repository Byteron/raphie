extends Boss
class_name Clasher

export var vision := 200
export var ram_range := 150
export var bite_range := 75
export var ram_damage := 20
export var bite_damage := 30

func _ready():
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("seek", "Seek")
	fsm.register_state("ram", "Ram")
	fsm.register_state("bite", "Bite")
	fsm.register_state("stunned", "Stunned")

func bite() -> void:
	var bodies = hit_area.get_overlapping_bodies()

	# Audio.play_sfx("player_slash")

	for body in bodies:
		if body is Character and body.team_number != team_number:
			if not body.dead:
				body.hurt(global_position, bite_damage)

func is_player_in_vision() -> bool:
	return _is_player_in_range(vision)

func is_player_in_ram_range() -> bool:
	return _is_player_in_range(ram_range)

func is_player_in_bite_range() -> bool:
	return _is_player_in_range(bite_range)

func _is_player_in_range(distance: int) -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < distance

func _on_RamArea_body_entered(body: PhysicsBody2D) -> void:

	if not fsm.is_current_state("Ram"):
		return

	if body is Player:
		body.hurt(global_position - Vector2(0, 50), ram_damage)
		Audio.play_sfx("alien_ram_player")
