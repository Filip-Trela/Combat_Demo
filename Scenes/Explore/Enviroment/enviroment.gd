extends Node3D

var player


func _process(delta):
	global_position.z = player.global_position.z
	
	#emmm dunno, pozniej sie zmieni
	$AnimationPlayer["speed_scale"] = 1 - player.velocity.z/60
	
