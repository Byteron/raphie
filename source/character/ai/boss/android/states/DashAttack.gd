extends State

var bounces := 0

export var dash_speed := 420
export var max_bounces := 3

onready var post_bounce_timer := $PostBounceTimer as Timer

func enter(host: Node) -> void:
	host = host as Android

	host.anim_player.play("dash")

	if not post_bounce_timer.is_connected("timeout", self, "_on_PostBounceTimer_timeout"):
		post_bounce_timer.connect("timeout", self, "_on_PostBounceTimer_timeout", [ host ])

func input(host: Node, event: InputEvent) -> void:
	host = host as Android

func update(host: Node, delta: float) -> void:
	host = host as Android

	host.motion.x = dash_speed * host.get_direction()

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_on_wall():
		host.flip()
		bounces += 1
		post_bounce_timer.start()

func exit(host: Node) -> void:
	host = host as Android
	bounces = 0

func _on_PostBounceTimer_timeout(host: Android) -> void:
	if bounces >= max_bounces:
		host.fsm.change_state("shoot_attack")
