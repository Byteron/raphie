extends State

func enter(host: Node) -> void:
	host = host as Android
	host.anim_player.play("seek")

func input(host: Node, event: InputEvent) -> void:
	host = host as Android

func update(host: Node, delta: float) -> void:
	host = host as Android

	var direction = host.get_player_direction()

	if direction == 1:
		host.flip_right()
	elif direction == -1:
		host.flip_left()
	else:
		host.fsm.change_state("idle")

	host.fsm.change_state("dash_attack")

func exit(host: Node) -> void:
	host = host as Android