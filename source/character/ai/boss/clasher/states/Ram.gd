extends State

export var speed = 220
export var ram_time := 2.0

onready var ram_timer := $RamTimer as Timer
var direction := 0

func enter(host: Node) -> void:
	host = host as Clasher
	host.anim_player.play("walk")
	direction = host.get_player_direction()

	if not ram_timer.is_connected("timeout", self, "_on_RamTimer_timeout"):
		ram_timer.connect("timeout", self, "_on_RamTimer_timeout", [ host ])

	ram_timer.start(ram_time)

func input(host: Node, event: InputEvent) -> void:
	host = host as Clasher

func update(host: Node, delta: float) -> void:
	host = host as Clasher

	if direction == 1:
		host.motion.x = speed
		host.flip_right()
	elif direction == -1:
		host.motion.x = -speed
		host.flip_left()

	if host.is_on_floor():
		host.motion.y = 0
	else:
		host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_on_wall():
		ram_timer.stop()
		get_tree().call_group("RockSpawner", "spawn_rocks", (Global.Player.global_position + host.global_position) / 2, 150, rand_range(2, 4))
		get_tree().call_group("GameCam", "shake", 35, 0.18, 4)
		Audio.play_sfx("alien_ram_player")
		host.fsm.change_state("stunned")

func exit(host: Node) -> void:
	host = host as Clasher

func _on_RamTimer_timeout(host: Clasher) -> void:
	host.fsm.change_state("seek")