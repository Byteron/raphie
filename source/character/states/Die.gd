extends State

func enter(host: Node) -> void:
	host = host as Character
	host.stop_anim()
	host.anim_player.play("die")

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.x = lerp(host.motion.x, 0, 0.05)
	host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)