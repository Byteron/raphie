extends State

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Character
	timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Character

	var player_direction = host.get_player_direction()

	if player_direction == -1 and not host.anim_player.is_playing():
		host.flip_right()
	elif player_direction == 1 and not host.anim_player.is_playing():
		host.flip_left()

	if host.is_player_in_vision() and timer.is_stopped() and not host.disabled and host.can_move:
		host.fsm.change_state("shoot")
