extends Node3D

var rot_dir:int
var speed = 0.05 
var player


func _process(_delta):
	self.rotation.y += rot_dir * speed
	
func _input(_event):
	#mozliwe ze trzeba bedzie zmienic
	rot_dir = int(Input.get_action_raw_strength("a") - Input.get_action_raw_strength("d"))


func delete_self(): 
	
	self.queue_free()

