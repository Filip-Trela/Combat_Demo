extends Node

#WEAPONS
var baseweapon = {
	"name": "base",
	"description": "A base weapon",
	"strengths": [1,0,0],
	"stagger": 5,
	"id": 000
}

var katana = {
	"name": "katana",
	"description": "Katana with sheath",
	"strengths": [0,0,0],
	"stagger": 3,
	"id": 001
}

var canon = {
	"name": "canon",
	"description": "Big canon",
	"strengths": [0,0,0],
	"stagger": 5,
	"id": 002
}


var all_weapons = [baseweapon, katana, canon]

func find_weapon(id):
	for weapon in all_weapons:
		if weapon.id == id:
			return weapon
	






#FIGURES
var basearmor ={
	"name": "basefigure",
	"description": "A base figure",
	"id": 000
}

var lightarmor ={
	"name": "light",
	"description": "Figure with light armor",
	"id": 001
}

var heavyarmor ={
	"name": "heavy",
	"description": "Figure with heavy armor",
	"id": 002
}


var all_armor = [basearmor, lightarmor, heavyarmor]

func find_armor(id):
	for armor in all_armor:
		if armor.id == id:
			return armor






#ITEMS
var base_item ={
	"name": "baseitem",
	"description": "A base item",
	"throw_pl": "res://Scenes/Combat/Items/knife/knife.tscn",
	#hp, mp that is substracted, stagger
	"use_on_enemy": [0,50, 5],
	#hp, mp that is added
	"use_on_self":[0,0],
	"id": 000
}

var heal_potion ={
	"name": "healing potion",
	"description": "Healing potion",
	"throw_pl": "res://Scenes/Combat/Items/knife/knife.tscn",
	"use_on_enemy": [0,50, 5],
	"use_on_self":[20, -10],
	"id": 001
}

var magic_potion ={
	"name": "magic potion",
	"description": "Magic potion",
	"throw_pl": "res://Scenes/Combat/Items/knife/knife.tscn",
	"use_on_enemy": [0,50, 5],
	"use_on_self":[0,50],
	"id": 002
}

var knife={
	"name": "knife",
	"description": "A knife",
	"throw_pl": "res://Scenes/Combat/Items/knife/knife.tscn",
	"use_on_enemy": [0,50, 5],
	"use_on_self":[-40, 0],
	"id": 003
}

var all_items = [base_item, heal_potion, magic_potion]

func find_item(id):
	for item in all_items:
		if item.id == id:
			return item
