extends Node2D


@onready var label:Label = $Node2D/Label
@onready var anim:AnimationPlayer = $AnimationPlayer

var texture: ViewportTexture


var text = "null"


func _ready():
	label.text = text
	$Node2D/Sprite2D["modulate"] = PlayerInfo.color_sex
	anim.play("start")
	




func _on_animation_player_animation_finished(anim_name):
	queue_free()
