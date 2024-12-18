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

var hands = {
	"name": "Hands",
	"description": "unarmed",
	"strengths": [1,0,0],
	"weapon_scene": "res://Scenes/MainLoop/Weapons/Hand/hand_weapon.tscn",
	"attacks": [Actions.strong_punch_hand],
	"stagger": 5,
	"id": 003
}

var gun_maul = {
	"name": "Gun Maul",
	"description": "It's a gun, looking like maul",
	"strengths": [1,0,0],
	"weapon_scene": "res://Scenes/MainLoop/Weapons/Gun_Maul/gun_maul.tscn",
	"attacks": [
	Actions.double_strike_maul,
	Actions.pierce_maul
	],
	"stagger": 5,
	"id": 003
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
	"mesh": "res://Scenes/MainLoop/Armors/BaseArmor/base_armor.tscn",
	"id": 000
}

var tattered_armor ={
	"name": "Tattered Armor",
	"description": "Armor tattered by many battles",
	"mesh": "res://Scenes/MainLoop/Armors/Tattered_armor/tattered_armor.tscn",
	"id": 001
}



var all_armor = [basearmor, tattered_armor]

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
