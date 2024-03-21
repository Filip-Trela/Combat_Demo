extends Sprite3D

class_name Sprite_Static



@onready var viewport = $SubViewport
var texture_2d



func _ready():
	texture_to_3d()
	self.offset.x = - texture.get_size().x * 0.5
	sort_z()
	print(0)
	
	



func _process(_delta):
	texture_to_3d()


func sort_z():
	self.sorting_offset = -int(self.global_position.z)*100


func texture_to_3d():
	texture = viewport.get_texture()
	self.texture = texture
