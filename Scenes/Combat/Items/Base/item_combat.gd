extends CharacterBody3D

var item

@export var speed:int = 10
@export var weight = 0.5
@export var y_toss = 10

var mov_vec = Vector3(0,y_toss, speed)
var max_grav = -20

func _physics_process(delta):
	if PlayerInfo.is_moving:
		
		mov_vec.y -= weight
		mov_vec.y = clamp(mov_vec.y, max_grav, 100)
		
		
		velocity = mov_vec
		move_and_slide()




func _on_enemy_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent().get_parent()
	enemy.item_damage(item)
	#tutaj nowa funkcja dla enemy zwiazana z damage lecz przez itemy
	#enemy.take_damage





func _on_world_hitbox_body_entered(body):
	queue_free()
