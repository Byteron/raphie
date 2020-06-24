extends State

var direction := 1

export var max_speed := 160
export var acceleration := 8

onready var shoot_timer := $Timer as Timer
onready var flip_timer := $FlipTimer as Timer

func enter(host: Node) -> void:
	host = host as Drone
	host.play_lower("hover")
	shoot_timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Drone

	if not host.can_move or host.disabled:
		direction = 0
		host.motion = Vector2(0, 0)
	else:
		direction = -1 if host.is_flipped() else 1

	if direction == 1 and host.terrain_on("right"):
		direction = -1
	elif direction == -1 and host.terrain_on("left"):
		direction = 1

	if host.is_too_far_from_origin() and flip_timer.is_stopped():
		direction *= -1
		flip_timer.start()

	if direction == -1:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	elif direction == 1:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()

	host.move_and_slide(host.motion, Global.UP)

	if host.is_player_in_shoot_range() and shoot_timer.is_stopped() and not host.disabled and host.can_move:
		host.shoot()
		shoot_timer.start()
