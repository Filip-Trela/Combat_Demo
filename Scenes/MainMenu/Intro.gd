extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")
	get_parent().get_node("MainMenu/2D").visible = false
	get_parent().get_node("MainMenu").visible = true
	get_parent().get_node("MainMenu/2D").set_process_mode(Node.PROCESS_MODE_DISABLED)
	get_parent().get_node("Transition").visible = false




func _on_animation_player_animation_finished(anim_name):
	get_parent().get_node("MainMenu/2D").visible = true
	get_parent().get_node("MainMenu/2D").set_process_mode(Node.PROCESS_MODE_INHERIT)
	get_parent().get_node("Transition").visible = true
