extends Node2D

var boss

# Called when the node enters the scene tree for the first time.
func _ready():
	$Name.text = boss.boss_name
	$ProgressBar.max_value = boss.max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = boss.current_hp
