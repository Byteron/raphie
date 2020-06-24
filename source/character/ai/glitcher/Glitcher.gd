extends Patrol
class_name Glitcher

export var damage := 2

func flip_left() -> void:
	lower.sprite.flip_h = true
	hit_area.position.x = -25

func flip_right() -> void:
	lower.sprite.flip_h = false
	hit_area.position.x = 25

func attack():
	var bodies = hit_area.get_overlapping_bodies()

	Audio.play_sfx("player_slash")

	for body in bodies:
		if body is Character and body.team_number != team_number:
			body.hurt(global_position, damage)
