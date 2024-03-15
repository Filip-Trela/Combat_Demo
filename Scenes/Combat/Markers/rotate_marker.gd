extends Node3D

var rot_dir:int
var speed = 0.05 


func _process(delta):
	self.rotation.y += rot_dir * speed
	
func _input(event):
	rot_dir = Input.get_action_raw_strength("a") - Input.get_action_raw_strength("d")
	
