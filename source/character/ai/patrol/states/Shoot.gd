extends State

var shots := 0

export var max_shots := 2

func enter(host: Node) -> void:
	host = host as Patrol
	host.play_lower("shoot")

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if shots < max_shots:

		if not host.lower.anim_player.is_playing():
			shots += 1

	elif not host.can_move:
		host.fsm.change_state("idle")
	elif host.is_player_in_retreat_range():
		host.fsm.change_state("retreat")
	else:
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Patrol
	host.shoot_timer.start()
	shots = 0