extends State

var time := 0.0

export var fall_delay := 0.2

export var jump_force := 350
export var slide_limit := 80
export var fast_slide_limit := 350

onready var slide_delay_timer := $SlideDelayTimer

func enter(host: Node) -> void:
	host = host as Player
	host.motion.x = 0
	host.stop_anim()
	slide_delay_timer.start()
	host.anim_player.play("hang")

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("jump"):

		if not host.is_flipped():
			host.motion.x = -jump_force
		else:
			host.motion.x = jump_force

		host.flip()
		host.fsm.change_state("jump")
	
	elif event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Player

	var input_direction = host.get_input_direction()
	
	if slide_delay_timer.is_stopped():
		if Input.is_action_pressed("ui_down"):
			host.motion.y = clamp(host.motion.y + Global.GRAVITY * delta / 10, 0, fast_slide_limit)
		else:
			host.motion.y = clamp(host.motion.y + Global.GRAVITY * delta * 10, 0, slide_limit)

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_on_floor():
		host.fsm.change_state("idle")
	elif not host.is_on_slide_wall():
		host.fsm.change_state("fall")
	elif host.is_turning_on_wall():
		time += delta
		if time > fall_delay:
			host.flip()
			host.fsm.change_state("fall")
	
	else:
		time = 0.0

func exit(host: Node) -> void:
	host = host as Player
	host.anim_player.play("reset")
	host.call_deferred("reset_modulate")
