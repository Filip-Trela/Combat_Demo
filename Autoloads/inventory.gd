extends Node

#WEAPONS
var baseweapon = {
	"name": "base",
	"id": 000
}

var katana = {
	"name": "katana",
	"id": 001
}

var canon = {
	"name": "canon",
	"id": 002
}


var all_weapons = [baseweapon, katana, canon]

func find_weapon(id):
	for weapon in all_weapons:
		if weapon.id == id:
			return weapon
	






#FIGURES
var basefigure ={
	"name": "basefigure",
	"id": 000
}

var lightfigure ={
	"name": "light",
	"id": 001
}

var heavyfigure ={
	"name": "heavy",
	"id": 002
}


var all_figures = [basefigure, lightfigure, heavyfigure]

func find_figure(id):
	for figure in all_figures:
		if figure.id == id:
			return figure






#ITEMS
var base_item ={
	"name": "baseitem",
	"id": 000
}

var heal_potion ={
	"name": "healing potion",
	"id": 001
}

var magic_potion ={
	"name": "magic potion",
	"id": 002
}

var all_items = [base_item, heal_potion, magic_potion]

func find_item(id):
	for item in all_items:
		if item.id == id:
			return item
