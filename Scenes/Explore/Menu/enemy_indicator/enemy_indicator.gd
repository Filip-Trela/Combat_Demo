extends Node2D

func _ready():
	$Front["modulate"] = PlayerInfo.color_sex

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Start":
		$AnimationPlayer.play("Idle")
	elif anim_name == "Hide":
		queue_free()
		
func end():
	$AnimationPlayer.play("Hide")
