extends Node3D

class_name EffectAnimation

@onready var anims = $AnimationPlayer

@export var damage_base = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	anims.play("start")

func end():
	self.queue_free()


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	
	#later much more
	enemy.current_hp -= damage_base
