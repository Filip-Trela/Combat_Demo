extends Node2D


@onready var label:Label = $Node2D/Label
@onready var anim:AnimationPlayer = $Node2D/AnimationPlayer

var texture: ViewportTexture


var text = "null"


func _ready():
	label.text = text
	
	anim.play("start")
	

func delete():
	queue_free()


