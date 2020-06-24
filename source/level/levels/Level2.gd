extends Level

func _ready() -> void:
	Audio.play_song("GameLoop")
	Glitch.level = 1
