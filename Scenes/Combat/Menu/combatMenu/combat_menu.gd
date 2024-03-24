extends CanvasLayer


@onready var player = get_parent().get_node("World/Player")
@onready var timer:Timer = get_node("Timer")
@onready var label:Label = get_node("Label")
@onready var anims:AnimationPlayer = get_node("AnimationPlayer")
@onready var player_hp:ProgressBar = $PlayerHealth



var timer_time = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = timer_time
	timer.start()
	player_hp.max_value = PlayerInfo.max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(PlayerInfo.follows)
	if PlayerInfo.is_moving:
		timer.set_paused(false)
	else:
		timer.set_paused(true)
		
	label.text = str(snappedf(timer_time - timer.time_left, 0.1))
	
	player_hp.value = PlayerInfo.current_hp
	
	$Background.texture = $SubViewport.get_texture()




func _input(_event):
	if Input.is_action_just_pressed("tab") and not PlayerInfo.is_moving:
		if not anims.is_playing():
			PlayerInfo.during_follows = false

			
			if PlayerInfo.combat_state == "in menu" and get_node("ButtonHandler").state =="master_butt":
				get_node("ButtonHandler").choose_s = 0
				get_node("ButtonHandler").choose_m = 0
				get_node("ButtonHandler").master_butt_change()
				
				#exit anytime you want
				#get_node("ButtonHandler").state = "master_butt"

				anims.play("hideMenu")
				
			elif  PlayerInfo.combat_state == "moving":
				anims.play("showMenu")
				







func _c_menu_is():
	PlayerInfo.combat_state = "in menu"
	
func _c_menu_not():
	PlayerInfo.combat_state = "moving"

