extends CharacterBody3D


#first one is self but combat one
@export var combat_self:String = "res://Scenes/Combat/Enemies/PlaceholderEnemy/PlaceHolderEnemy.tscn"
@export var friend1:String ="res://Scenes/Combat/Enemies/PlaceholderEnemy/PlaceHolderEnemy.tscn"
@export var friend2:String 
@export var friend3:String 
@export var friend4:String 
@export var friend5:String 
var friends = [friend1, friend2, friend3, friend4, friend5]

var friend_list:Array = []

func _ready():
	for friend in friends:
		if friend:
			friend_list.append(friend)


	
