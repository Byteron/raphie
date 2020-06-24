extends State

func enter(host: Node) -> void:
	host = host as Player
	host.stop_anim()
	host.anim_player.play("crouch")
	host.crouch()

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Player

	if not host.is_on_floor():
		host.fsm.change_state("fall")
	elif not Input.is_action_pressed("ui_down"):
		host.fsm.change_state("idle")
	elif Input.is_action_pressed("shoot") and host.can_shoot():
		host.play_shoot(true)

func exit(host: Node) -> void:
	host = host as Player
	host.anim_player.stop()
	host.stand()
	host.reset_modulate()