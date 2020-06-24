extends Node2D
class_name Projectile

var speed := 1600
var damage := 1

var shooter : Character = null

var direction := Vector2()

var fired := false

export var max_distance := 500

onready var area := $Sprite/Projectile as Area2D
onready var sprite := $Sprite as Sprite

func _physics_process(delta: float) -> void:
	if fired:
		sprite.position.x += speed * delta
		if sprite.position.distance_to(Vector2(0,0)) > max_distance:
			queue_free()

func fire(damage: int, speed: int, direction : Vector2 = Vector2(1, 0)) -> void:

	self.speed = speed
	self.damage = damage
	self.fired = true

	# directional shooting
	# rotation_degrees = dir2rot(direction)

	match direction:
		Vector2.DOWN: rotation_degrees = 90
		Vector2.UP: rotation_degrees = -90
		Vector2.LEFT: rotation_degrees = -180
		Vector2.RIGHT: rotation_degrees = 0

func _on_Area2D_body_entered(body) -> void:

#	print(body.name)

	if body is Character and shooter and shooter.team_number != body.team_number:
		body.hurt(global_position, damage)
		queue_free()
	elif not body is Character:
		queue_free()

func dir2rot(direction: Vector2) -> float:
	var rot := 0.0

	if direction.x == -1 and not direction.y:
		return 180.0

	if direction.y:
		rot += 90 * direction.y

	if direction.x:
		rot -= 45 * direction.x * direction.y

	return rot

func _on_Projectile_area_entered(area: Area2D) -> void:
	if area.name == "Projectile":
		if area.get_node("../..").shooter != shooter:
			queue_free()

func _on_Projectile_tree_exited() -> void:
	queue_free()
