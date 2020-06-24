extends Area2D

const PATH = "res://source/level/levels/"

export var next_level := "Level1"

func _on_Portal_body_entered(body: PhysicsBody2D) -> void:
	if body is Player and next_level:
		Scene.change(PATH + next_level + ".tscn")