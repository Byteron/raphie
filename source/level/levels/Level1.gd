extends Level

func _ready() -> void:
	Audio.play_song("Level1")
	Audio.play_ambience()
	Glitch.level = GameSaver.glitch_level

func _exit_tree() -> void:
	Audio.stop_ambience()