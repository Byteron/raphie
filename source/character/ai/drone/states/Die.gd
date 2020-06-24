extends State

var host : Drone = null

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Drone
	self.host = host as Drone
	host.stop_anim()
	timer.start()
	host.spawn_sparks()

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.x = lerp(host.motion.x, 0, 0.05)
	host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

func _on_Timer_timeout() -> void:
	host.anim_player.queue("die")