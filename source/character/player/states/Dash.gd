extends State

export var distance := 450

export var force := 1400
export var friction := 4500
export var max_dashes := 2

var direction := Vector2()

var dash_count := 0

var follow_dash := false

func enter(host: Node) -> void:
	host = host as Player
	host.play("dash")
	Audio.play_sfx("player_blink_start")
	host.dashing = true
	host.spawn_after_image()
	direction = host.get_input_direction()
	host.motion = Vector2(force, force) * direction
	host.dash_timer.start()
	host.energy -= host.dash_cost
	dash_count += 1
	# host.disable_collision()

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("dash"):
		follow_dash = true

func update(host: Node, delta: float) -> void:
	host = host as Player

	host.motion -= Vector2(friction, friction) * direction * delta
	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.motion.length() < 500:
		if follow_dash and dash_count < max_dashes:
			enter(host)
#		elif host.terrain_checker.is_in_terrain():
#			host.fsm.change_state("die")
		else:
			host.motion.x = 0
			host.fsm.change_state("fall")

func exit(host: Node) -> void:
	host = host as Player

	follow_dash = false
	host.dashing = false

	if dash_count:
		Audio.play_sfx("player_blink_end")

	dash_count = 0
	# host.enable_collision()
	host.reset_modulate()
	host.shoot_timer.start()
