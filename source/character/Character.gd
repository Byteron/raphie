extends KinematicBody2D
class_name Character

signal state_changed(state_name)

signal health_changed(health)

signal hurt(damage)

signal died

var motion := Vector2()

var health setget _set_health

var bottom_limit := 99999

var disabled := false setget _set_disabled

var dead := false

export var flip_on_start := true

export var can_move := true

export var team_number := 0

export var max_health := 2

onready var anim_player := $AnimationPlayer as AnimationPlayer

onready var tween := $Tween as Tween

onready var upper := {
	anim_player = $Upper/AnimationPlayer,
	sprite = $Upper/Sprite
}

onready var lower := {
	anim_player = $Lower/AnimationPlayer,
	sprite = $Lower/Sprite
}

onready var particle_spawner := $ParticleSpawner as ParticleSpawner

onready var collision_shape := $CollisionShape2D as CollisionShape2D

onready var hit_area := $HitArea as Area2D

onready var fsm := $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:

	if flip_on_start:
		call_deferred("flip_left")

	_register_host()
	_register_states()
	fsm.register_state("die", "Die")
	health = max_health
	move_and_slide_with_snap(Vector2(0,0), Global.DOWN, Global.UP)

func _physics_process(delta: float) -> void:
	if tween.is_active():
		move_and_slide_with_snap(motion, Global.DOWN, Global.UP)

func _register_states() -> void:
	print("Character::_ready->_setup_states: Overwrite!")

func hurt(origin: Vector2, damage: int) -> void:

	if dead:
		return

	_tween_hurt()
	knockback(origin, damage * 20)
	Audio.play_sfx("player_hurt")
	spawn_hit(origin)
	_set_health(health - damage)
	emit_signal("hurt", damage)

func play(anim_name: String) -> void:

	if not upper.anim_player.current_animation == "attack":
		upper.anim_player.play(anim_name)
	lower.anim_player.play(anim_name)

func play_upper(anim_name: String) -> void:
	upper.anim_player.play(anim_name)

func play_lower(anim_name: String) -> void:
	lower.anim_player.play(anim_name)

func stop_anim() -> void:
	upper.anim_player.stop()
	lower.anim_player.stop()

func spawn_hit(origin: Vector2) -> void:
	particle_spawner.spawn_hit(origin, global_position, 31)

func spawn_jump_dust() -> void:
	particle_spawner.spawn_jump_dust(global_position)

func spawn_dash_dust() -> void:
	particle_spawner.spawn_dash_dust(global_position, is_flipped())

func spawn_stop_dust() -> void:
	particle_spawner.spawn_stop_dust(global_position, 31, is_flipped())

func spawn_land_dust() -> void:
	particle_spawner.spawn_land_dust(global_position, 31, is_flipped())

func spawn_sparks() -> void:
	particle_spawner.spawn_explosion("spark", global_position, 30)

func spawn_explosion() -> void:
	particle_spawner.spawn_explosion("explode", global_position, 30)

func enable_collision() -> void:
	collision_shape.disabled = false

func disable_collision() -> void:
	collision_shape.disabled = true

func flip() -> void:
	if is_flipped():
		flip_right()
	else:
		flip_left()

func flip_left() -> void:
	upper.sprite.flip_h = true
	lower.sprite.flip_h = true
	hit_area.position.x = -40

func flip_right() -> void:
	upper.sprite.flip_h = false
	lower.sprite.flip_h = false
	hit_area.position.x = 40

func is_flipped() -> bool:
	return lower.sprite.flip_h

func get_direction() -> int:
	return -1 if is_flipped() else 1

func get_player_direction() -> int:

	if not Global.Player:
		return 1

	return -1 if Global.Player.global_position.x < global_position.x else 1

func slash() -> void:
	pass

func shoot() -> void:
	pass

func enable_movement() -> void:
	can_move = true

func disable_movement() -> void:
	can_move = false

func set_team_number(value: int) -> void:
	team_number = value

func set_bottom_limit(value) -> void:
	bottom_limit = value

func get_current_frame() -> int:
	return lower.sprite.frame

func knockback(origin: Vector2, knockback:int) -> void:

	if knockback < 10:
		return

	var direction = origin.direction_to(global_position)

	tween.interpolate_property(self, "motion", direction * knockback, Vector2(0, 0), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func reset_modulate() -> void:
	modulate = Color("FFFFFF")
	upper.visible = true
	lower.visible = true
	upper.sprite.modulate = Color("FFFFFFFF")
	lower.sprite.modulate = Color("FFFFFFFF")

func _tween_hurt() -> void:
	tween.interpolate_property(self, "modulate", Color("FFFFFF"), Color("FF0000"), 0.01, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color("FF0000"), Color("FFFFFF"), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT, 0.01)
	tween.start()

func _register_host() -> void:
	fsm.host = self

func _set_disabled(value):
	disabled = value
	fsm.set_process_unhandled_input(!value)
	set_process_input(!value)

func _set_health(value) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health)
	if health == 0:
		emit_signal("died")
		dead = true

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	emit_signal("state_changed", state_name)

func _on_Upper_AnimationPlayer_animation_finished(anim_name: String) -> void:
	pass

func _on_Character_died() -> void:
	fsm.change_state("die")
