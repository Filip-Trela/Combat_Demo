extends Node3D

var rot_dir:int
var speed = 0.05 


func _process(_delta):
	self.rotation.y += rot_dir * speed
	
func _input(_event):
	rot_dir = int(Input.get_action_raw_strength("a") - Input.get_action_raw_strength("d"))

	
