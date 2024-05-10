extends Node2D

var dialog
var keys
var index = 0

var option_state = false

var choose_opt = 0
var opt_nr = 1
var opt_is = false

#im not sure anymore
@onready var player = get_parent().get_parent().get_node("Player")


func _ready():
	visible = false
	
	
	
func start(dia):
	$Option1.visible = false
	$Option2.visible = false
	$Main.text = ""
	$Opt1.text = ""
	$Opt2.text = ""
	visible = true
	var file = FileAccess.get_file_as_string(dia)
	dialog = JSON.parse_string(file)
	keys = dialog.keys()
	PlayerInfo.explore_state = "talking"


func _input(event):
	if opt_is:
		if PlayerInfo.explore_state == "talking":
			if Input.is_action_just_pressed("w"): 
				choose_opt -=1
				if choose_opt < 0:
					choose_opt = opt_nr
				change_option()
			
			
			elif Input.is_action_just_pressed("s"):
				choose_opt += 1
				if choose_opt >opt_nr:
					choose_opt = 0
				change_option()
			
			elif Input.is_action_just_pressed("e"):
				if opt_is: 
					$Option1.visible = false
					$Option2.visible = false
					if choose_opt == 0:
						index = int(dialog[keys[0]][index][4])
					elif choose_opt == 1:
						index = int(dialog[keys[0]][index][5])
					keep()
					
					
	elif PlayerInfo.explore_state == "talking":
		if Input.is_action_just_pressed("e"):
			keep()

func change_option():
	if choose_opt == 0:
		$Option1.visible = true
		$Option2.visible = false
	elif choose_opt ==1:
		$Option1.visible = false
		$Option2.visible = true

func keep():
	opt_is = false
	$Main.text = ""
	$Opt1.text = ""
	$Opt2.text = ""
	match dialog[keys[0]][index][0]:
		"npc_text":
			choose_opt = 0
			$Main.text = dialog[keys[0]][index][1]
			index +=1
			
		"text-option":
			opt_is = true
			choose_opt = 0
			option_state = true
			$Option1.visible = true
			$Option2.visible = false
			$Main.text = dialog[keys[0]][index][1]
			$Opt1.text = dialog[keys[0]][index][2]
			$Opt2.text = dialog[keys[0]][index][3]

			
		"end":
			end()
			


func end():
	choose_opt = 0
	PlayerInfo.explore_state = "moving"
	index = 0
	visible = false
	
