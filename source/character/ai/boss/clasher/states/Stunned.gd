extends State

export var stun_time := 2.0

onready var stun_timer := $StunTimer as Timer

func enter(host: Node) -> void:
	host = host as Clasher
	host.hurt(host.global_position, 10)
	host.anim_player.play("idle", -1, 0.3)

	if not stun_timer.is_connected("timeout", self, "_on_StunTimer_timeout"):
		stun_timer.connect("timeout", self, "_on_StunTimer_timeout", [ host ])

	stun_timer.start(stun_time)

func _on_StunTimer_timeout(host: Clasher) -> void:
	host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Clasher

	stun_timer.stop()
