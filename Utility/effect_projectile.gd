extends Node3D

class_name EffectProjectile

@onready var anims = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anims.play("start")

func end():
	self.queue_free()
