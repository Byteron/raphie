extends State

export var average_wait_time := 3.0

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Character
	host.play("idle")

	if not timer.is_connected("timeout", self, "_on_Timer_timeout"):
		timer.connect("timeout", self, "_on_Timer_timeout", [ host ])

	randomize()

	timer.wait_time = rand_range(0.0, average_wait_time * 2)
	timer.start()

func _on_Timer_timeout(host: Character) -> void:
	if host.can_move:
		host.fsm.change_state("walk")
	else:
		timer.start()