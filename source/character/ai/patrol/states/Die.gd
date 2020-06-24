extends State

func enter(host) -> void:
	host = host as Patrol
	host.stop_anim()
	host.anim_player.queue("die")

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	host.motion.x = lerp(host.motion.x, 0, 0.05)