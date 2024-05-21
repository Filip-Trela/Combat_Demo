extends CanvasLayer


@onready var player = get_parent().get_node("Player")
@onready var anims:AnimationPlayer = get_node("AnimationPlayer")
@onready var player_hp:ProgressBar = $PlayerHealth
@onready var player_mp:ProgressBar = $PlayerMana
@onready var player_sp:ProgressBar = $PlayerSp
@onready var stamina:Timer = $StaminaSystem





# Called when the node enters the scene tree for the first time.
func _ready():
	player_hp.max_value = PlayerInfo.max_hp
	player_mp.max_value = PlayerInfo.max_mp
	player_sp.max_value = PlayerInfo.max_sp
	PlayerInfo.current_sp = clamp(PlayerInfo.current_sp, -1, PlayerInfo.max_sp)
	player_sp.value = PlayerInfo.current_sp
	
	stamina.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Settings.stopped_time:
		Settings.current_time = move_toward(Settings.current_time,\
		Settings.stop_time, Settings.change_time)
	else:

		Settings.current_time = move_toward(Settings.current_time,\
		Settings.move_time, Settings.change_time)
	$Sprite2D['modulate'] = Color(1, 1, 1, 0.3 - (Settings.current_time + 0.1))
	PlayerInfo.current_hp = clamp(PlayerInfo.current_hp, -1, PlayerInfo.max_hp)
	player_hp.value = PlayerInfo.current_hp
	
	PlayerInfo.current_mp = clamp(PlayerInfo.current_mp, -1, PlayerInfo.max_mp)
	player_mp.value = PlayerInfo.current_mp
	
	stamina_system()





func stamina_system():
	if PlayerInfo.combat_state == "during action" or player.dodge_is:
		stamina.start(PlayerInfo.sp_time_rec)
	
	PlayerInfo.current_sp = clamp(PlayerInfo.current_sp, -1, PlayerInfo.max_sp)
	player_sp.value = PlayerInfo.current_sp
	if stamina.time_left ==0: 
		PlayerInfo.current_sp += PlayerInfo.sp_recovery
		PlayerInfo.sp_recovery = move_toward(PlayerInfo.sp_recovery ,\
		PlayerInfo.sp_recovery_max, PlayerInfo.sp_recovery_change)
	else:
		PlayerInfo.sp_recovery = PlayerInfo.sp_recovery_min

func _c_menu_is():
	PlayerInfo.combat_state = "in menu"
	
func _c_menu_not():
	PlayerInfo.combat_state = "moving"

