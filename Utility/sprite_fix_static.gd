extends Sprite3D

class_name Sprite_Static

@export var size_x = 512
@export var size_y = 512

@onready var viewport = $SubViewport
var texture_2d

func _ready():
	viewport.size = Vector2(size_x, size_y)

	
	texture_to_3d()
	self.offset.x = - texture.get_size().x * 0.5
	sort_z()

func _process(delta):
	texture_to_3d()


func sort_z():
	self.sorting_offset = -int(self.global_position.z)*100


func texture_to_3d():
	texture = viewport.get_texture()
	self.texture = texture
