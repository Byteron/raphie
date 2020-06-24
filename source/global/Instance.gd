extends Node

const Dust = preload("res://source/particles/Dust.tscn")
const Pulse = preload("res://source/particles/Pulse.tscn")
const Explosion = preload("res://source/particles/Explosion.tscn")
const Hit = preload("res://source/particles/Hit.tscn")

const AfterImage = preload("res://source/particles/AfterImage.tscn")

const Projectile = preload("res://source/projectiles/Projectile.tscn")

const Rock = preload("res://source/objects/Rock.tscn")

const KeyButton = preload("res://source/interface/KeyButton.tscn")

const Speech = preload("res://source/cutscene/Speech.tscn")

func Dust(): return Dust.instance()
func Pulse(): return Pulse.instance()
func Explosion(): return Explosion.instance()
func Hit(): return Hit.instance()


func AfterImage(): return AfterImage.instance()

func Projectile(): return Projectile.instance()

func Rock(): return Rock.instance()

func KeyButton(): return KeyButton.instance()

func Speech() -> Speech: return Speech.instance() as Speech