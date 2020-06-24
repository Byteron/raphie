extends State

func enter(host: Node) -> void:
	host = host as Clasher
	host.motion.x = 0
	host.anim_player.play("idle")

func input(host: Node, event: InputEvent) -> void:
	host = host as Clasher

func update(host: Node, delta: float) -> void:
	host = host as Clasher

	if host.is_active() and not host.is_player_in_vision():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Clasher