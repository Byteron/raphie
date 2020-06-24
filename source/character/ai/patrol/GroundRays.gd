extends Node2D

onready var left_ray := $Left
onready var right_ray := $Right

func is_on_cliff() -> bool:
	return left_ray.get_collider() == null or right_ray.get_collider() == null