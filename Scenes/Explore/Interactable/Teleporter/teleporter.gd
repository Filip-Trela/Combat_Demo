extends StaticBody3D

var states = [
	"main_butt",
	"teleport_butt"
]
var state = "main_butt"

var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1

var slave_nr = 0
var slave_node
var choose_s = 0

func _ready():
	mas_nr = $"2D_part/MainButtons".get_child_count() -1
	main_butt_change()
	
func interact():
	PlayerInfo.explore_state = "teleporter"
	$"2D_part".visible = true

func _input(event):
	if PlayerInfo.explore_state == "teleporter": 
		match state:
			"main_butt":
				if Input.is_action_just_pressed("w"):
					choose_m  -=1
					if choose_m < 0:
						choose_m = mas_nr
					main_butt_change()
				
				elif Input.is_action_just_pressed("s"):
					choose_m  +=1
					if choose_m > mas_nr:
						choose_m =0 
					main_butt_change() 
				
				elif Input.is_action_just_pressed("space"): 
					mas_node.activate()
					
				elif Input.is_action_just_pressed("q"):
					choose_m = 0 
					$"2D_part".visible = false
					PlayerInfo.explore_state = "moving"
					
					
			
			"teleport_butt":
				if Input.is_action_just_pressed("w"):
					choose_s  -=1
					if choose_s < 0:
						choose_s = slave_nr
					teleport_butt_change()
					
					
				elif Input.is_action_just_pressed("s"):
					choose_s  +=1
					if choose_s > slave_nr:
						choose_s =0 
					teleport_butt_change()
				
				elif Input.is_action_just_pressed("space"): 
					var transition = get_tree().current_scene.get_node("Transition")
					transition.teleport(int(slave_node.get_node("Label").text))
						
					PlayerInfo.explore_state = "moving"
					
				
				elif Input.is_action_just_pressed("q"):
					$"2D_part/TeleportButtons".visible = false
					$"2D_part/MainButtons".visible = true
					slave_nr = 0
					slave_node = null
					choose_s = 0

					state = "main_butt"

func main_butt_change():
	mas_node = $"2D_part/MainButtons".get_child(choose_m)

func teleport_butt_change():
	slave_node = $"2D_part/TeleportButtons".get_child(choose_s)
	for button in $"2D_part/TeleportButtons".get_children():
		button.scale = Vector2(1,1)
	slave_node.scale = Vector2(1.1, 1.1)
