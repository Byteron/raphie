extends Control

onready var tween := $Tween as Tween
onready var anim := $AnimationPlayer as AnimationPlayer

onready var health_bar := $HP as TextureProgress
onready var health_bar_back := $HPBack as TextureProgress
onready var energy_bar := $EP as TextureProgress
onready var energy_bar_back := $EPBack as TextureProgress

func update_health(health: int) -> void:
	health_bar.value = health
	tween.interpolate_property(health_bar_back, "value", health_bar_back.value, health, 0.35, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	anim.play("hurt")

func update_energy(energy: int) -> void:
	energy_bar.value = energy
	tween.interpolate_property(energy_bar_back, "value", energy_bar_back.value, energy, 0.35, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func set_max_health(max_health: int, reset := true) -> void:
	health_bar.max_value = max_health
	health_bar_back.max_value = max_health

	if reset:
		health_bar.value = max_health
		health_bar_back.value = max_health


func set_max_energy(max_energy: int, reset := true) -> void:
	energy_bar.max_value = max_energy
	energy_bar_back.max_value = max_energy

	if reset:
		energy_bar.value = max_energy
		energy_bar_back.value = max_energy

func shake_energy_bar() -> void:
	anim.play("shake_energy_bar")
