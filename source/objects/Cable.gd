extends Sprite

func _on_Area2D_body_entered(body):
	if body is Player:
		body.hurt(global_position, 25)