extends CanvasLayer



@onready var main_butt = $MainButtons



var states = [
	"main_butt",
	"start_butt"
]
var state = "main_butt"

var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1

var slave_nr =0
var slave_node =0
var choose_s = 0




func _ready(): 
	PlayerInfo.transition =get_parent().get_parent().get_node("Transition")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mas_nr = $MainButtons.get_child_count() - 1
	main_butt_change()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#for a moment only
	for button in $StartButtons.get_children():
		button.scale = Vector2(1,1)
	if slave_node:
		slave_node.scale = Vector2(1.5, 1.5)


func _input(event):
	state_machine()

func state_machine():
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
		
		
		"start_butt": 
			if Input.is_action_just_pressed("d"):
				choose_s += 1
				if choose_s > slave_nr:
					choose_s = 0
				start_butt_change(choose_s)
					
			elif Input.is_action_just_pressed("a"):
				choose_s -=1
				if choose_s < 0:
					choose_s = slave_nr
				start_butt_change(choose_s)
				
			elif Input.is_action_just_pressed("space"):
				slave_node.activate()
			
			elif Input.is_action_just_pressed("q"):
				slave_nr = 0
				slave_node = 0
				choose_s = 0
				$MainButtons.visible = true
				$StartButtons.visible = false
				state = "main_butt"
				
				
		"set_butt": 
			if Input.is_action_just_pressed("d"):
				choose_s += 1
				if choose_s > slave_nr:
					choose_s = 0
				set_butt_change(choose_s)
					
			elif Input.is_action_just_pressed("a"):
				choose_s -=1
				if choose_s < 0:
					choose_s = slave_nr
				set_butt_change(choose_s)
				
			elif Input.is_action_just_pressed("space"):
				slave_node.activate()
			
			elif Input.is_action_just_pressed("q"):
				slave_nr = 0
				slave_node = 0
				choose_s = 0
				$MainButtons.visible = true
				$SettingButtons.visible = false
				state = "main_butt"



func main_butt_change():
	mas_node = $MainButtons.get_child(choose_m)	
	for button in $MainButtons.get_children():
		button.scale = Vector2(1,1)
	mas_node.scale = Vector2(1.2, 1.2)

func start_butt_change(nr):
	slave_node = $StartButtons.get_child(nr)
	for button in $StartButtons.get_children():
		button.scale = Vector2(1,1)
	slave_node.scale = Vector2(1.2, 1.2)

func set_butt_change(nr):
	slave_node = $SettingButtons.get_child(nr)
	for button in $SettingButtons.get_children():
		button.scale = Vector2(1,1)
	slave_node.scale = Vector2(1.2, 1.2)
	
