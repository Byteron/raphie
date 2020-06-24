extends State

export var max_speed := 450
export var acceleration := 20
export var friction := 0.4

export var fall_threshold := 1200
export var fall_margin := 500

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host.motion.y = 0
	host = host as Player
	host.play("fall")

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("attack"):
		host.attack("air_attack")

	if event.is_action_pressed("dash") and host.can_dash():
		host.fsm.change_state("dash")

	if event.is_action_pressed("jump"):
		timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Player

	var input_direction = host.get_input_direction()

	if host.is_on_wall():
		host.motion.x = 0

	host.motion.y += Global.GRAVITY * delta

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

	if host.is_on_cliff():
		host.fsm.change_state("hang")

	elif host.is_on_slide_wall():
		host.fsm.change_state("slide")

	elif host.is_on_floor():

		Audio.play_sfx("player_land")

		var damage = _calc_fall_damage(host.motion.y)

		if damage:
			host.hurt(host.global_position, damage)

		if not timer.is_stopped() and not host.dead and host.can_move:
			host.fsm.change_state("jump")
		elif host.motion.x and not host.dead and host.can_move:
			host.fsm.change_state("walk")
		elif not host.dead:
			host.fsm.change_state("idle")

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if Input.is_action_pressed("shoot") and host.can_shoot() and not host.disabled:
		host.play_shoot()

func exit(host: Node) -> void:
	host.spawn_land_dust()
	host = host as Character
	host.motion.y = 0

func _calc_fall_damage(height: int) -> int:
	var damage := 0

	if height > fall_threshold:
		damage = 100 * (height - fall_threshold) / fall_margin

	print("Height: %d, Damage: %d" % [height, damage])

	return damage
