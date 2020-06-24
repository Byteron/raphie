extends Boss
class_name Android

export var shoot_damage = 10
export var dash_damage = 20

func _ready() -> void:
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("seek", "Seek")
	fsm.register_state("dash_attack", "DashAttack")
	fsm.register_state("shoot_attack", "ShootAttack")

func flip_left() -> void:
	upper.sprite.flip_h = true
	lower.sprite.flip_h = true
	hit_area.position.x = -27

func flip_right() -> void:
	upper.sprite.flip_h = false
	lower.sprite.flip_h = false
	hit_area.position.x = 27

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = global_position + Vector2(0, -36)
	get_tree().current_scene.add_child(projectile)
	projectile.fire(shoot_damage, 360, Vector2(get_direction(), 0))
	Audio.play_sfx("gun_shot")

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	print(name, ": ", state_name)

func _on_HitArea_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		body.hurt(global_position - Vector2(0, 50), dash_damage)
