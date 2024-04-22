extends StaticBody3D

@onready var train = get_parent()
@export var combat_world:String

func _on_start_area_body_entered(body):
	get_parent().create_start()


func _on_end_area_body_entered(body):
	get_parent().create_end()

func monitor():
	$Activs/StartArea.set_deferred('monitoring', true)
	$Activs/EndArea.set_deferred('monitoring', true)
	
func not_monitor():
	$Activs/StartArea.set_deferred('monitoring', false)
	$Activs/EndArea.set_deferred('monitoring', false)
