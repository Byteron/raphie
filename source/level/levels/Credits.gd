extends Node

func _on_Cutscene_finished() -> void:
	Scene.change(Scene.Credits)
