extends StaticBody3D

var open = false

func interact():
	if open:
		$AnimationPlayer.play("Close")
		open = false
	else:
		$AnimationPlayer.play("Open")
		open = true
