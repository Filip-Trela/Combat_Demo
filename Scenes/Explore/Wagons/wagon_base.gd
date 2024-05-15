extends StaticBody3D

@onready var train = get_parent()
@export var combat_world:String

var enemy_list = []
var combat_in = false

var wagon_nr

	
	
func _process(delta):
	$AnimationPlayer.speed_scale = Settings.current_time
	
	if combat_in:
		if len(enemy_list) ==0:
			change_to_explore()
			
			
			
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


func change_to_combat():
	$AnimationPlayer.play("to_combat")
	combat_in = true
	
	for spawner in $Enemies.get_children():
		spawner.get_child(1).change_combat()
		enemy_list.append(spawner.get_child(1))
	Settings.enemy_list = enemy_list
	

	#ogarnianie wagonow
	var train = get_parent()
	if train.get_child(1) == self: 
		wagon_nr = 1
		train.get_child(2).visible = false
		train.get_child(3).visible = false
		
		train.get_child(2).set_process_mode(Node.PROCESS_MODE_DISABLED)
		train.get_child(3).set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	
	elif train.get_child(2) == self: 
		wagon_nr = 2
		train.get_child(1).visible = false
		train.get_child(3).visible = false
		
		train.get_child(1).set_process_mode(Node.PROCESS_MODE_DISABLED)
		train.get_child(3).set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	
	elif train.get_child(3) == self: 
		wagon_nr = 3
		train.get_child(1).visible = false
		train.get_child(2).visible = false
		
		train.get_child(1).set_process_mode(Node.PROCESS_MODE_DISABLED)
		train.get_child(2).set_process_mode(Node.PROCESS_MODE_DISABLED)
	

func change_to_explore():
	$AnimationPlayer.play("to_explore")
	var loop = get_parent().get_parent().get_parent().change_to_explore()
	combat_in = false
	
	if wagon_nr ==1:
		train.get_child(2).visible = true
		train.get_child(3).visible = true
		
		train.get_child(2).set_process_mode(Node.PROCESS_MODE_INHERIT)
		train.get_child(3).set_process_mode(Node.PROCESS_MODE_INHERIT)
	elif wagon_nr==2:
		train.get_child(1).visible = true
		train.get_child(3).visible = true
		
		train.get_child(1).set_process_mode(Node.PROCESS_MODE_INHERIT)
		train.get_child(3).set_process_mode(Node.PROCESS_MODE_INHERIT)
	elif wagon_nr ==3:
		train.get_child(1).visible = true
		train.get_child(2).visible = true
		
		train.get_child(1).set_process_mode(Node.PROCESS_MODE_INHERIT)
		train.get_child(2).set_process_mode(Node.PROCESS_MODE_INHERIT)
