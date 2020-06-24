extends State

export var speed = 160

func enter(host: Node) -> void:
	host = host as Clasher
	host.anim_player.play("walk", -1, 0.6)

func input(host: Node, event: InputEvent) -> void:
	host = host as Clasher

func update(host: Node, delta: float) -> void:
	host = host as Clasher

	var direction = host.get_player_direction()

	if direction == 1:
		host.motion.x = speed
		host.flip_right()
	elif direction == -1:
		host.motion.x = -speed
		host.flip_left()
	else:
		host.fsm.change_state("idle")

	if host.is_on_floor():
		host.motion.y = 0
	else:
		host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_player_in_bite_range():
		host.fsm.change_state("bite")
	elif host.is_player_in_ram_range():
		host.fsm.change_state("ram")

func exit(host: Node) -> void:
	host = host as Clasher