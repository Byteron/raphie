extends State

onready var timer := $Timer as Timer
onready var tween := $Tween as Tween

func enter(host: Node) -> void:
	host = host as Glitcher

func input(host: Node, event: InputEvent) -> void:
	host = host as Glitcher

func update(host: Node, delta: float) -> void:
	host = host as Glitcher

	var direction = host.get_player_direction()

	if host.is_player_in_attack_range() and timer.is_stopped() and not tween.is_active():

		if direction < 0:
			host.flip_left()
		elif direction > 0:
			host.flip_right()

		host.play_lower("attack")
		_tween_attack(host, direction)
		timer.start()

	elif not host.can_move:
		host.fsm.change_state("idle")
	elif not host.is_player_in_attack_range():
		host.fsm.change_state("seek")

	if host.is_player_in_attack_range() and host.is_player_behind() and not tween.is_active():
		_tween_backflip(host, host.get_player_direction())
	elif host.get_player_distance() < 40 and not tween.is_active():
		_tween_backwards(host, direction)

func exit(host: Node) -> void:
	host = host as Glitcher

func _tween_attack(host: Glitcher, direction: int) -> void:
	tween.interpolate_property(host, "motion:x", 6 * host.get_player_distance() * direction, 0, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT, 0.1)
	tween.start()

func _tween_backwards(host: Glitcher, direction: int) -> void:
	tween.interpolate_property(host, "motion:x", 4 * host.attack_range * -direction, 0, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT, 0.1)
	tween.start()

func _tween_backflip(host: Glitcher, direction: int) -> void:
	tween.interpolate_property(host, "motion:x", 4 * host.attack_range * -direction, 0, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT, 0.1)
	tween.start()
	host.flip()
