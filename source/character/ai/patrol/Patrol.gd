extends Character
class_name Patrol

var origin := Vector2()

export var vision := 350
export var move_range := 100
export var attack_range := 60
export var retreat_range := 60
export var shoot_range := 200
export var bullet_speed := 500
export var bullet_damage := 0

onready var shoot_timer := $ShootTimer as Timer

onready var barrel := $Barrel as Position2D

onready var ground_rays := $GroundRays

func _ready() -> void:
	$FiniteStateMachine/Walk.radius = move_range

	origin = global_position
	fsm.change_state("idle")

func _physics_process(delta: float) -> void:

	if is_on_floor():
		motion.y = 0
	else:
		motion.y += Global.GRAVITY * delta

	move_and_slide_with_snap(motion, Global.DOWN, Global.UP)

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("seek", "Seek")
	fsm.register_state("attack", "Attack")
	fsm.register_state("retreat", "Retreat")

func flip_left() -> void:
	.flip_left()
	barrel.position.x = -14

func flip_right() -> void:
	.flip_right()
	barrel.position.x = 14

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().current_scene.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(get_direction(), 0))

func get_random_target_position(move_radius: float) -> Vector2:
	randomize()
	var rand = rand_range(-move_radius, move_radius)

	var new_target_position :=  Vector2(origin.x + rand, global_position.y)

	return new_target_position

func can_shoot() -> bool:
	return shoot_timer.is_stopped()

func get_player_distance() -> float:
	return global_position.distance_to(Global.Player.global_position)

func is_player_in_attack_range() -> bool:
	return _is_player_in_range(attack_range)

func is_player_in_retreat_range() -> bool:
	return _is_player_in_range(retreat_range)

func is_player_in_shoot_range() -> bool:
	return _is_player_in_range(shoot_range)

func is_player_in_vision() -> bool:
	return _is_player_in_range(vision)

func is_on_cliff() -> bool:
	return ground_rays.is_on_cliff()

func is_player_behind() -> bool:

	if not Global.Player:
		return false

	var direction = -1 if is_flipped() else 1

	return direction != get_player_direction()

func _is_player_in_range(distance: int) -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < distance
