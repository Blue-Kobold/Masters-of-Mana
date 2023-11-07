extends Node2D

@export var number_of_cards_to_gen : int = 100

var card : Dictionary = {}
var rng

var affinities : Array = [
	"Order",
	"Mind",
	"Ambition",
	"Chaos",
	"Nature",
	"Spirit",
	"None"
]

var opposed_affinities : Dictionary = {
	"Order" : "Chaos",
	"Mind" : "Nature",
	"Ambition" : "Spirit",
	"Chaos" : "Order",
	"Nature" : "Mind",
	"Spirit" : "Ambition",
}

var soul_types : Dictionary = {
	
	"Order" : {
		"None" : "Paladin",
		"Mind" : "Construct",
		"Ambition" : "Noble",
		"Nature" : "Hunter",
		"Spirit" : "Angel"},
		
	"Mind" : {
		"None" : "Wizard",
		"Ambition" : "Rogue",
		"Chaos" : "Horror",
		"Spirit" : "Cleric",
		"Order" : "Construct"},
		
	"Ambition" : {
		"None" : "Dragon",
		"Chaos" : "Demon",
		"Nature" : "Dinosaur",
		"Order" : "Noble",
		"Mind" : "Rogue"},
		
	"Chaos" : {
		"None" : "Warrior",
		"Nature" : "Fae",
		"Spirit" : "Cultist",
		"Mind" : "Horror",
		"Ambition" : "Demon"},
		
	"Nature" : {
		"None" : "Beast",
		"Spirit" : "Elemental",
		"Order" : "Hunter",
		"Ambition" : "Dinosaur",
		"Chaos" : "Fae"},
		
	"Spirit" : {
		"None" : "Undead",
		"Order" : "Angel",
		"Mind" : "Cleric",
		"Chaos" : "Cultist",
		"Nature" : "Elemental"}
	}


func _ready():
	generate_card()


func generate_card():
	for i in number_of_cards_to_gen:
		card.merge(roll_for_mana_cost(rnginator(6)))
		card.merge(roll_for_card_affinity(rnginator(8)))
		match roll_for_card_type(rnginator(2)):
			"Soul":
				card.merge({"Card Type" : "Soul"})
				card.merge(roll_for_soul_type(rnginator(12)))
				card.merge(roll_for_soul_stats(rnginator(8)))
				print(str(card))
				clear_card()
			"Magic":
				card.merge({"Card Type" : "Magic"})
				print(str(card))
				clear_card()
	
	
func clear_card():
	card.clear()
	

func rnginator(dice_size):
	rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1, dice_size)
	
	
func roll_for_mana_cost(mana_cost_roll_result):
	match mana_cost_roll_result:
		1,2:
			return { "Mana Cost" : "0" }
		3,4:
			return { "Mana Cost" : "1" }
		5:
			return { "Mana Cost" : "2" }
		6:
			return { "Mana Cost" : "3" }
	
	
func roll_for_card_affinity(card_affinity_roll_result):
	match card_affinity_roll_result:
		1:
			return { "Primary Affinity" : "Order",
					 "Secondary Affinity" : "None" }
		2:
			return { "Primary Affinity" : "Mind",
					 "Secondary Affinity" : "None" }
		3:
			return { "Primary Affinity" : "Ambition",
					 "Secondary Affinity" : "None" }
		4:
			return { "Primary Affinity" : "Chaos",
					 "Secondary Affinity" : "None" }
		5:
			return { "Primary Affinity" : "Nature",
					 "Secondary Affinity" : "None" }
		6:
			return { "Primary Affinity" : "Spirit",
					 "Secondary Affinity" : "None" }
		7, 8:
			var primary_affinity = roll_for_card_affinity(rnginator(6))
			var secondary_affinity = roll_for_card_affinity(rnginator(6))
			while primary_affinity["Primary Affinity"] == secondary_affinity["Primary Affinity"] or opposed_affinities[primary_affinity["Primary Affinity"]] == secondary_affinity["Primary Affinity"]:
				secondary_affinity = roll_for_card_affinity(rnginator(6))
			return { "Primary Affinity" : str(primary_affinity["Primary Affinity"]),
					 "Secondary Affinity" : str(secondary_affinity["Primary Affinity"])}
	
	
func roll_for_card_type(card_type_roll_result):
	match card_type_roll_result:
		1:
			return "Soul"
		2:
			return "Magic"
					

func roll_for_soul_type(soul_type_roll_result):
	match soul_type_roll_result:
		1,2,3,4:
			return { "Primary Soul Type" : soul_types[card["Primary Affinity"]][card["Secondary Affinity"]],
					 "Secondary Soul Type" : "None"}
		5,6,7,8,9,10:
			var off_soul_type = soul_types[card["Primary Affinity"]].values().pick_random()
			while off_soul_type == soul_types[card["Primary Affinity"]][card["Secondary Affinity"]]:
				off_soul_type = soul_types[card["Primary Affinity"]].values().pick_random()
			return { "Primary Soul Type" : off_soul_type,
					 "Secondary Soul Type" : "None"}
		11,12:
			var secondary_soul_type = soul_types[card["Primary Affinity"]].values().pick_random()
			while secondary_soul_type == soul_types[card["Primary Affinity"]][card["Secondary Affinity"]]:
				secondary_soul_type = soul_types[card["Primary Affinity"]].values().pick_random()
			return { "Primary Soul Type" : soul_types[card["Primary Affinity"]][card["Secondary Affinity"]],
					 "Secondary Soul Type" : secondary_soul_type}


func roll_for_soul_stats(soul_stats_roll_result):
	var damage : int = 1
	var health : int = 1
	var number_of_bonuses : int = 0
	var number_of_drawbacks : int = 0
	var keywords : Array
	match soul_stats_roll_result:
		1:
			damage = 0
			number_of_bonuses = 2
		2:
			number_of_bonuses = 1
		3:
			health = 2
		4:
			damage = 2
		5:
			damage = 2
			health = 2
			number_of_drawbacks = 1
		6:
			damage = 2
			health = 3
			number_of_drawbacks = 2
		7:
			damage = 3
			health = 2
			number_of_drawbacks = 2
		8:
			damage = 3
			health = 3
			number_of_drawbacks = 3
	while number_of_bonuses != 0:
		roll_for_bonuses(rnginator(12))
		number_of_bonuses -= 1
	while number_of_drawbacks != 0:
		roll_for_drawbacks(rnginator(6))
		number_of_drawbacks -= 1
	
func roll_for_bonuses(bonuses_roll_result):
	pass
	
func roll_for_drawbacks(drawbacks_roll_result):
	pass
