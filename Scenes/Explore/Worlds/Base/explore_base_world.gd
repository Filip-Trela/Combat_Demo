extends Node3D

#maybe array of world
@export var combat_world:String



# Called when the node enters the scene tree for the first time.
func _ready():
	$WorldArea.set_deferred("monitoring", true)


func _on_world_area_body_entered(body):
	PlayerInfo.transition.load_com_world = combat_world
	for world in get_parent().get_children():
		world.set_active()
	
	set_inactive()
	


#and there children are unactive but area is
func set_active(): 
	$WorldArea.set_deferred("monitoring", true)
	$Activs.visible = false
	$Activs.process_mode = 4
	
#so children are active but not area

func set_inactive():
	$WorldArea.set_deferred("monitoring", false)
	$Activs.visible = true
	$Activs.process_mode = 0

### some optimilizatoin needed, like if world is monitoring there are no visible nor processing enemies
### and when is not monitoring everything is processing and vissible
