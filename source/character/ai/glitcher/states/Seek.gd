extends State

export var speed = 120

func enter(host: Node) -> void:
	host = host as Patrol
	host.play_lower("walk")

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	host.motion.x = host.get_player_direction() * speed

	if host.motion.x < 0:
		host.flip_left()
	else:
		host.flip_right()

	if not host.can_move:
		host.fsm.change_state("idle")
	elif host.is_player_in_attack_range() and not host.can_shoot():
		host.fsm.change_state("idle")
	elif host.is_player_in_attack_range() and host.can_shoot():
		host.fsm.change_state("attack")
	elif not host.is_player_in_vision() or host.is_on_wall() or host.is_player_in_attack_range():
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Patrol
	host.motion.x = 0