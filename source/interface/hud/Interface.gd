extends CanvasLayer
class_name Interface

onready var raphie_plate := $RaphiePlate
onready var key_preview := $KeyPreview
onready var enemy_plate := $EnemyPlate

func _ready() -> void:
	Controller.connect("device_changed", self, "_on_Controller_device_changed")

func show_key(action: String) -> void:
#	print("show key: ", action)
	key_preview.new_key(action)

func hide_key():
	key_preview.clear()

func show() -> void:
	raphie_plate.show()

func hide() -> void:
	raphie_plate.hide()

func _on_Controller_device_changed() -> void:
	key_preview.update_key()

