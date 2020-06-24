extends State

export var speed := 160

func enter(host: Node) -> void:
	host = host as Patrol
	host.play_lower("walk")

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if host.is_on_floor():
		host.motion.y = 0
	else:
		host.motion.y += Global.GRAVITY * delta

	host.motion.x = -host.get_player_direction() * speed

	if host.motion.x < 0:
		host.flip_left()
	else:
		host.flip_right()

	if not host.can_move:
		host.fsm.change_state("idle")
	elif host.is_on_wall():
		host.flip()
		host.fsm.change_state("attack")
	elif host.is_on_cliff() or not host.is_player_in_attack_range():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Patrol
	host.motion.x = 0