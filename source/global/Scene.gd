extends CanvasLayer

# Scenes
const TitleScreen := "res://source/interface/menu/TitleScreen.tscn"
const Credits := "res://source/interface/menu/Credits.tscn"
const Settings := "res://source/interface/menu/Settings.tscn"
const GameOver := "res://source/interface/menu/GameOver.tscn"

const Level := {
	1: "res://source/level/levels/Level1.tscn",
	2: "res://source/level/levels/Level2.tscn",
	3: "res://source/level/levels/Level3.tscn"
}

var next_scene := ""
var prev_scene := ""

var changing := false
var show_bar := false

onready var scene_loader := $SceneLoader as SceneLoader
onready var anim := $AnimationPlayer as AnimationPlayer
onready var progress_bar := $TextureProgress as TextureProgress

func change(scene: String, show_bar: bool = false) -> void:
	
	if changing:
		return
	
	changing = true
	self.show_bar = show_bar
	prev_scene = next_scene
	next_scene = scene
	anim.play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		scene_loader.load_interactive(next_scene)
		progress_bar.max_value = scene_loader.get_stage_count()

func _on_ProgressBar_value_changed(value: float) -> void:
	if progress_bar.max_value == value:
		progress_bar.visible = false
	elif not progress_bar.visible and show_bar:
		progress_bar.visible = true

func _on_SceneLoader_scene_loaded(scene) -> void:
	get_tree().change_scene_to(scene)
	anim.play("fade_in")
	changing = false

func _on_SceneLoader_stage_changed(stage) -> void:
	progress_bar.value = stage
