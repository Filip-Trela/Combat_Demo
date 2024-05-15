extends CanvasLayer


@onready var player = get_parent().get_node("World/Player")
@onready var anims:AnimationPlayer = get_node("AnimationPlayer")
@onready var player_hp:ProgressBar = $PlayerHealth
@onready var player_mp:ProgressBar = $PlayerMana






# Called when the node enters the scene tree for the first time.
func _ready():
	$Background1["modulate"] = PlayerInfo.color_sex
	player_hp.max_value = PlayerInfo.max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PlayerInfo.is_moving:
		Settings.current_time = move_toward(Settings.current_time,\
		Settings.move_time, Settings.change_time)
	else:
		Settings.current_time = move_toward(Settings.current_time,\
		Settings.stop_time, Settings.change_time)
	
	PlayerInfo.current_hp = clamp(PlayerInfo.current_hp, -1, PlayerInfo.max_hp)
	player_hp.value = PlayerInfo.current_hp
	
	PlayerInfo.current_mp = clamp(PlayerInfo.current_mp, -1, PlayerInfo.max_mp)
	player_mp.value = PlayerInfo.current_mp
	
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

