extends StaticBody3D





func _on_in_obstacle_body_entered(body):
	body.on_obstacle = true


func _on_in_obstacle_body_exited(body):
	body.on_obstacle = false
