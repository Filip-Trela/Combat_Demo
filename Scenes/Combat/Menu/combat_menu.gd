extends CanvasLayer


@onready var player = get_parent().get_node("World/Player")
@onready var timer:Timer = get_node("Timer")
@onready var label:Label = get_node("Label")
@onready var anims:AnimationPlayer = get_node("AnimationPlayer")

var timer_time = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = timer_time
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PlayerInfo.is_moving:
		timer.set_paused(false)
	else:
		timer.set_paused(true)
		
	label.text = str(snappedf(timer_time - timer.time_left, 1))




func _input(_event):
	if Input.is_action_just_pressed("tab") and not PlayerInfo.is_moving:
		if not anims.is_playing():
			
			if PlayerInfo.combat_state == "in menu" and get_node("ButtonHandler").state =="master_butt":
				get_node("ButtonHandler").choose_s = 0
				get_node("ButtonHandler").choose_m = 0
				anims.play("hideMenu")
				
			elif  PlayerInfo.combat_state == "moving":
				anims.play("showMenu")







func _c_menu_is():
	PlayerInfo.combat_state = "in menu"
	
func _c_menu_not():
	PlayerInfo.combat_state = "moving"

