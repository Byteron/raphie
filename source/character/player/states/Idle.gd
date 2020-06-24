extends State

func enter(host: Node) -> void:
	host = host as Player
	host.play("idle")
	host.motion = Vector2(0,0)

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("jump"):
		host.fsm.change_state("jump")

	if event.is_action_pressed("attack"):
		host.attack("attack")

	if event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Player

	var input_direction = host.get_input_direction()

	if not host.is_on_floor():
		host.fsm.change_state("fall")

	elif Input.is_action_pressed("ui_down"):
		host.fsm.change_state("crouch")

	elif input_direction.x and host.can_move:
		host.fsm.change_state("walk")

	elif Input.is_action_pressed("shoot") and host.can_shoot():
		host.play_shoot()

	elif input_direction.x < 0:
		host.flip_left()
	elif input_direction.y > 0:
		host.flip_right()