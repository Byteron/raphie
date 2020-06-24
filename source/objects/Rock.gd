extends Node2D

onready var rock := $Rock as Area2D

export var damage := 25

var speed := rand_range(250, 280)
var motion = 0

var hit := false

onready var tween := $Tween as Tween
onready var break_player := $BreakPlayer
onready var impact_player := $ImpactPlayer

func _ready() -> void:
	break_player.play()

func _physics_process(delta: float) -> void:

	if not hit:
		motion = clamp(motion + 20, 0, speed)

	rock.global_position.y += motion * delta

func _on_Rock_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		body.hurt(global_position, damage)
		_tween_hit()
	elif not body is Character:
		_tween_hit()

func _tween_hit() -> void:
	hit = true
	motion = clamp(motion, 0, 100)
	get_tree().call_group("GameCam", "shake", 15, 0.1, 2)
	tween.interpolate_property(self, "motion", motion, 0, 0.2, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.2, Tween.TRANS_QUAD, Tween.EASE_IN, 0.2)
	tween.start()
	impact_player.play()

func _on_Tween_tween_all_completed() -> void:
	queue_free()
