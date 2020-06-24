extends Character
class_name Civilian

var origin := Vector2()

func _ready() -> void:
	origin = global_position
	fsm.change_state("idle")

func _register_states():
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")

func get_random_target_position(move_radius: float) -> Vector2:
	randomize()
	var rand = rand_range(-move_radius, move_radius)

	var new_target_position :=  Vector2(origin.x + rand, global_position.y)

	return new_target_position