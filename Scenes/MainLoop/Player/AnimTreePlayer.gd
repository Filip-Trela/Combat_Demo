extends AnimationTree

var player
var anim


var tween_stop
var stop_amount = 1
var stop_speed =0.1


func _ready():
	player = get_parent().get_parent()
	anim = self
	tween_stop = get_tree().create_tween()
	self["parameters/Transition/transition_request"] = "Movement"



func _process(delta):
	#print(self["parameters/Attacks/playback"])
	state_machine()
	#print(self["parameters/Transition/transition_request"])
	#anim.stop()

func state_machine():
	#for stoping animation
	anim.set("parameters/Stop/scale", Settings.current_time)

		
	#movement
	#anim["parameters/Movement/blend_position"] = Vector2(player.xz_vec).length() / player.max_speed

func play_combat(name):
	self["parameters/Transition/transition_request"] = "Attack"
	self["parameters/Attacks/playback"].start(name)
	
	

func _on_animation_finished(anim_name):
	if anim_name == "Die":
		PlayerInfo.transition.play("combat_to_explore_playerdies")
		
	elif anim_name == "attack_explore" or anim_name == "Dodge":
		PlayerInfo.explore_state = "moving"
		self["parameters/Transition/transition_request"] = "Movement"
		
	elif self["parameters/Transition/current_state"] == "Attack":
		PlayerInfo.combat_state = "moving"
		self["parameters/Transition/transition_request"] = "Movement"
		




