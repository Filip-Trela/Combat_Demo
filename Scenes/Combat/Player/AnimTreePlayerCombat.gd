extends AnimationTree

var player
var anim


var tween_stop
var stop_amount = 1
var stop_speed =0.1


func _ready():
	player = get_parent()
	anim = get_parent().get_node("AnimTreePlayerCombat")
	tween_stop = get_tree().create_tween()

func _process(delta):
	state_machine()
	#anim.stop()

func state_machine():
	#for stoping animation
	if PlayerInfo.is_moving:
		anim.set("parameters/Stop/scale", 1)
	else: 
		anim.set("parameters/Stop/scale", 0)
		
	#movement
	anim["parameters/Movement/blend_position"] = Vector2(player.xz_vec).length() / player.max_speed
