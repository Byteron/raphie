extends State

func enter(host: Node) -> void:
	host = host as Android
	host.motion.x = 0
	host.anim_player.play("idle")

func input(host: Node, event: InputEvent) -> void:
	host = host as Android

func update(host: Node, delta: float) -> void:
	host = host as Android

	if host.is_active():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Android