extends State

export var jump_force := 450
export var max_speed := 450
export var acceleration := 20
export var friction := 0.4

func enter(host: Node) -> void:
	host = host as Player
	host.play("jump")
	Audio.play_sfx("player_jump")
	host.spawn_jump_dust()
	host.motion.y = -jump_force

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

	if event.is_action_pressed("attack"):
		host.attack("attack")

func update(host: Node, delta: float) -> void:
	host = host as Player

	var input_direction = host.get_input_direction()

	if host.is_on_wall():
		host.motion.x = 0

	host.motion.y += Global.GRAVITY * delta

	if not Input.is_action_pressed("jump") and not Input.is_action_pressed("ui_up"):
		jump_cut(host)

	if input_direction.x == 1:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()
	elif input_direction.x == -1:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	else:
		host.motion.x = lerp(host.motion.x, 0, friction)
		if abs(host.motion.x) < 0.1:
			host.motion.x = 0

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.motion.y >= 0 or host.is_on_ceiling():
		host.fsm.change_state("fall")

	if host.is_on_floor():
		host.fsm.change_state("idle")

	if Input.is_action_pressed("shoot") and host.can_shoot():
		host.play_shoot()

func jump_cut(host: Player) -> void:
    if host.motion.y < -100:
        host.motion.y = -100
