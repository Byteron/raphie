extends "res://source/character/states/Die.gd"

func enter(host: Node) -> void:
	host = host as Turret
	host.spawn_sparks()
	host.stop_anim()
	host.anim_player.queue("die")

func update(host: Node, delta: float) -> void:
	host = host as Turret