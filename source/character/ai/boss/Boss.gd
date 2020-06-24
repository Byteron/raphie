extends Character
class_name Boss

var active := false

func _ready():
	set_physics_process(false)

func knockback(origin: Vector2, knockback: int) -> void:
	pass # overwrite, so it does not have a knockback

func setup_enemy_plate() -> void:
	var enemy_plate = get_tree().get_nodes_in_group("EnemyPlate")[0]

	enemy_plate.set_max_health(max_health)
	enemy_plate.reset()
	enemy_plate.show()
	connect("health_changed", enemy_plate, "update_health")
	connect("died", self, "_on_Boss_died")

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false

func is_active() -> bool:
	return active

func _on_Boss_died() -> void:
	get_tree().call_group("EnemyPlate", "hide")