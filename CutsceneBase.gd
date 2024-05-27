extends Node3D
var shift_pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	$ForAnimation/Camera3D.current = true
	shift_pivot = get_tree().current_scene.get_node("MainLoop/ShiftPivot")
	shift_pivot.set_process_mode(Node.PROCESS_MODE_DISABLED)
	shift_pivot.visible = false



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "cutscene":
		$ForAnimation.set_process_mode(Node.PROCESS_MODE_DISABLED)
		$ForAnimation.visible = false
		$ForAnimation/Camera3D.current = false
		shift_pivot.set_process_mode(Node.PROCESS_MODE_INHERIT)
		shift_pivot.visible = true
		$AnimationPlayer.play("end")
		
	elif anim_name == "end":
		self.queue_free()
