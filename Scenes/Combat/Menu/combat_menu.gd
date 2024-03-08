extends CanvasLayer


@onready var player = get_parent().get_node("Player")
@onready var timer:Timer = get_node("Timer")
var timer_time = 500
@onready var label:Label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = timer_time
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInfo.is_moving:
		timer.set_paused(false)
	else:
		timer.set_paused(true)
		
	label.text = str(snappedf(timer_time - timer.time_left, 1))
