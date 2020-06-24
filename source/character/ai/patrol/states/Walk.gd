extends State

var target_position := Vector2()

export var speed := 250
export var radius := 250

func enter(host: Node) -> void:
	host = host as Patrol
	host.play_lower("walk")
	target_position = host.get_random_target_position(radius)

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	var direction = -1 if host.global_position.x > target_position.x else 1

	host.motion.x = speed * direction

	if host.motion.x < 0:
		host.flip_left()
	else:
		host.flip_right()

	if host.global_position.distance_to(target_position) < 20 or host.is_on_cliff() or host.is_on_wall() or not host.can_move:
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Patrol
	host.motion.x = 0