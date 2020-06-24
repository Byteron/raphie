tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("MusicBooth", "Node", preload("source/music/MusicBooth.gd"), preload("graphics/icons/icon.png"))
	add_custom_type("Song", "Node", preload("source/music/Song.gd"), preload("graphics/icons/icon.png"))

func _exit_tree() -> void:
	remove_custom_type("MusicBooth")
	remove_custom_type("Song")