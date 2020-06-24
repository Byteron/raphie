extends State

var time := 0.0

export var fall_delay := 0.2

func enter(host: Node) -> void:
	host = host as Player
	host.motion.x = 0
	host.stop_anim()
	host.anim_player.play("hang")

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("jump"):
		host.cliff_timer.start()
		host.fsm.change_state("jump")

	elif event.is_action_pressed("ui_down"):
		host.cliff_timer.start()
		host.fsm.change_state("slide")
	
	elif event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Player
	
	if host.is_turning_on_wall():
		time += delta
		if time > fall_delay:
			host.flip()
			host.fsm.change_state("fall")
			host.cliff_timer.start()
	else:
		time = 0.0

func exit(host: Node) -> void:
	host = host as Player
	host.anim_player.play("reset")
	host.reset_modulate()
