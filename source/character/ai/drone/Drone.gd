extends Character
class_name Drone

export var bullet_damage := 1
export var bullet_speed := 250
export var seek_distance := 500
export var sound_distance := 2000

onready var hover_player := $Hover as AudioStreamPlayer

onready var origin := global_position

func _ready() -> void:
	hover_player.volume_db = linear2db(0.0)
	hover_player.play()
	lower.sprite.region_rect.position.y = 64 * (randi() % 3)
	fsm.change_state("idle")

func _process(delta: float) -> void:
	if Global.Player:
		var volume = 0.28 - (Global.Player.global_position.distance_to(global_position) / sound_distance)
		hover_player.volume_db = linear2db(clamp(volume, 0, 0.28))

onready var rays := {
	left = $Rays/Left,
	right = $Rays/Right,
	up = $Rays/Up,
	down = $Rays/Down
}

func _register_states():
	fsm.register_state("idle", "Idle")

func spawn_sparks():
	.spawn_sparks()

func spawn_explosion():
	.spawn_explosion()

func shoot() -> void:
#	print("shoot")
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = global_position
	get_tree().current_scene.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(0, 1))

func is_player_in_shoot_range() -> bool:

	if not Global.Player:
		return false

	var distance_vector = Global.Player.global_position - global_position
	distance_vector.y /= 20
	return distance_vector.length() < 100

func get_origin_direction() -> Vector2:
	return (origin - global_position).normalized()

func get_player_direction() -> int:

	if not Global.Player:
		return 1

	var direction = Global.Player.global_position.x - global_position.x

	return -1 if direction > 0 else 1

func terrain_on(direction: String) -> bool:

	if not rays[direction].is_colliding():
		return false

	var collider = rays[direction].get_collider()

	return collider == Global.Terrain

func is_too_far_from_origin() -> bool:
	return global_position.distance_to(origin) > seek_distance
