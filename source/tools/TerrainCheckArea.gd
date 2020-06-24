extends Area2D

func is_in_terrain():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body == Global.Terrain:
			return true
	return false