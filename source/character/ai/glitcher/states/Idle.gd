extends State

onready var idle_timer := $IdleTimer as Timer

func enter(host: Node) -> void:
	host = host as Patrol

	idle_timer.start()

	if not idle_timer.is_connected("timeout", self, "_on_IdleTimer_timeout"):
		idle_timer.connect("timeout", self, "_on_IdleTimer_timeout", [ host ])

	host.play_lower("idle")

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if host.is_on_floor():
		host.motion.y = 0
	else:
		host.motion.y += Global.GRAVITY * delta

	if host.is_player_in_attack_range() and host.can_shoot() and not host.disabled and host.can_move:
		host.fsm.change_state("attack")
	if host.is_player_in_vision() and not host.is_player_in_attack_range() and not host.disabled and host.can_move:
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Patrol
	idle_timer.stop()

func _on_IdleTimer_timeout(host: Patrol) -> void:
	if not host.disabled:
		host.fsm.change_state("walk")