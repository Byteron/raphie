extends State

var shots := 0

export var max_shots := 3

func enter(host: Node) -> void:
	host = host as Character
	host.anim_player.play("activate")

func update(host: Node, delta: float) -> void:
	host = host as Character

	if shots <= max_shots:

		if not host.anim_player.is_playing():
			host.anim_player.play("shoot")
			shots += 1

	elif not host.can_move:
		host.fsm.change_state("idle")
	else:
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Character
	shots = 0
	host.anim_player.play_backwards("activate")
