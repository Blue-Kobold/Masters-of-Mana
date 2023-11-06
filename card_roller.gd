extends Node2D

@export var number_of_cards_to_gen : int = 10 

var card : Dictionary = {}
var rng

func _ready():
	rng = RandomNumberGenerator.new()
	for i in number_of_cards_to_gen:
		print(roll_for_card_type(rnginator(2)))
		
func rnginator(i):
	rng.randomize()
	return rng.randi_range(1, i)
	
func roll_for_card_type(i):
	match i:
		1:
			return "Soul"
		2:
			return "Magic"
