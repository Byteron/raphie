extends Node
class_name ParticleSpawner

func spawn_explosion(anim_name: String, spawn_position: Vector2, offset: int) -> void:
	var explosion = Instance.Explosion()
	explosion.global_position = spawn_position - Vector2(0, offset)
	get_tree().current_scene.add_child(explosion)
	explosion.play(anim_name)

func spawn_hit(origin: Vector2, spawn_position: Vector2, offset: int) -> void:
	var hit = Instance.Hit()
	hit.global_position = spawn_position - Vector2(0, offset)
	get_tree().current_scene.add_child(hit)
	hit.look_at(origin - Vector2(0, offset))
	hit.play()

func spawn_jump_dust(spawn_position: Vector2) -> void:
	var dust = Instance.Dust()
	dust.global_position = spawn_position
	get_tree().current_scene.add_child(dust)
	dust.play("jump")

func spawn_dash_dust(spawn_position: Vector2, flipped: bool) -> void:
	var dust = Instance.Dust()
	dust.global_position = spawn_position
	get_tree().current_scene.add_child(dust)
	dust.play("dash", flipped)

func spawn_stop_dust(spawn_position: Vector2, distance: int, flipped: bool) -> void:
	var dust = Instance.Dust()
	get_tree().current_scene.add_child(dust)
	if flipped:
		dust.global_position = spawn_position - Vector2(distance, 0)
	else:
		dust.global_position = spawn_position + Vector2(distance, 0)
	dust.play("land", flipped)

func spawn_land_dust(spawn_position: Vector2, distance: int, flipped: bool) -> void:
	var dust_left = Instance.Dust()
	var dust_right = Instance.Dust()

	get_tree().current_scene.add_child(dust_left)
	get_tree().current_scene.add_child(dust_right)

	dust_left.global_position = spawn_position - Vector2(distance, 0)
	dust_right.global_position = spawn_position + Vector2(distance, 0)

	dust_left.play("land", true)
	dust_right.play("land")

func spawn_after_image(spawn_position: Vector2, flipped: bool) -> void:
	var image = Instance.AfterImage()
	image.global_position = spawn_position
	get_tree().current_scene.add_child(image)
	image.play(flipped)

func spawn_pulse_in(spawn_position: Vector2) -> void:
	var pulse = Instance.Pulse()
	pulse.global_position = spawn_position
	Global.Player.add_child(pulse)
	pulse.play("in")

func spawn_pulse_out(spawn_position: Vector2) -> void:
	var pulse = Instance.Pulse()
	pulse.global_position = spawn_position
	Global.Player.add_child(pulse)
	pulse.play("out")