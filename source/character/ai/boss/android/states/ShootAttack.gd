extends State

var time := 0.0
func enter(host: Node) -> void:
	host = host as Android
	host.anim_player.play("shoot")

func input(host: Node, event: InputEvent) -> void:
	host = host as Android

func update(host: Node, delta: float) -> void:
	host = host as Android

	time += delta

	if time > 1:
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Android
	time = 0.0
