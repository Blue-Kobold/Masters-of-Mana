extends Node2D


@export var number_of_cards_to_gen : int = 100


var card : Dictionary = {}
var rng : RandomNumberGenerator


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


var bonus_keywords_by_affinity : Dictionary = {
	"Order" : [
		"Guard",
		"Heroic",
		"Inspire",
		"Support",
		"Muster"
	],
	"Mind" : [
		"Oracle",
		"Attuned",
		"Ward",
		"Ritual",
		"Research"
	],
	"Ambition" : [
		"Pilfer",
		"Intimidation",
		"Misdirect",
		"Command",
		"Assassinate"
	],
	"Chaos" : [
		"Bloodthirsty",
		"Shove",
		"Reckless",
		"Taunt",
		"Warp"
	],
	"Nature" : [
		"Apex",
		"Predator",
		"Fearsome",
		"Carrion",
		"Growth"
	],
	"Spirit" : [
		"Haunting",
		"Ephemeral",
		"Healer",
		"Conjurer",
		"Revive"
	]
}


var bonus_keywords_by_soul_type : Dictionary = {
	"Paladin" : [
		"Oath",
		"Subduer",
		"Squire"
	],
	"Wizard" : [
		"Sagacious",
		"Autodidact",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Dragon" : [
		"Hoard",
		"Wyrmbreath",
		"Terrifying Presence"
	],
	"Warrior" : [
		"Weapon Master",
		"Berserk",
		"Barbarian"
	],
	"Beast" : [
		"Feral",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Undead" : [
		"Flesh Heap",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Construct" : [
		"Fundamental",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"Nullstone"
	],
	"Noble" : [
		"Tariff",
		"Diplomacy",
		"Lineage"
	],
	"Hunter" : [
		"Hunt",
		"Blend",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Angel" : [
		"Shield of Faith",
		"Reliquary",
		"Ring of Eyes",
	],
	"Rogue" : [
		"Sneaky",
		"Executioner",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Horror" : [
		"Unfathomable",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Cleric" : [
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"Oracle",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Demon" : [
		"Desecrator",
		"Blasphemous",
		"Profane"
	],
	"Dinosaur" : [
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Fae" : [
		"Trickster",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Cultist" : [
		"Sacrifice",
		"Idolator",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Elemental" : [
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	]
}


var advanced_bonus_keywords_by_affinity : Dictionary = {
	"Order" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Mind" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Ambition" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Chaos" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Nature" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Spirit" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))"
}


var advanced_bonus_keywords_by_soul_type : Dictionary = {
	"Paladin" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Wizard" : "Omniscient",
	"Dragon" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Warrior" : "Vengeance for the Fallen",
	"Beast" : "NEEDS KEYWORD HERE :)))))))))))))))))))))))),",
	"Undead" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Construct" : "BIG FUCKING LASER",
	"Noble" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Hunter" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Angel" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Rogue" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Horror" : "Eldritch Lore",
	"Cleric" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Demon" : "Contract",
	"Dinosaur" : "Rampage",
	"Fae" : "Suspicious Gift",
	"Cultist" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))",
	"Elemental" : "NEEDS KEYWORD HERE :))))))))))))))))))))))))"
}


var drawback_keywords_by_affinity : Dictionary = {
	"Order" : [
		"Pacifist",
		"Dogmatic",
		"Challenge",
		"Honorable",
		"Heretical"
	],
	"Mind" : [
		"Fragile",
		"Ancient",
		"Mad",
		"Clumsy",
		"Complex"
	],
	"Ambition" : [
		"Cowardly",
		"Dramatic",
		"Conceit",
		"Morbid",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	],
	"Chaos" : [
		"Aggressive",
		"Unstable",
		"Disloyal",
		"Unpredictable",
		"Unruly"
	],
	"Nature" : [
		"Savage",
		"Carnivore",
		"Insatiable",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))",
		"Solitary"
	],
	"Spirit" : [
		"Immaterial",
		"Necrotic",
		"Siphon",
		"Cursed",
		"NEEDS KEYWORD HERE :))))))))))))))))))))))))"
	]
}


func _ready():
	for i in number_of_cards_to_gen:
		generate_card()


func generate_card():
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
		keywords.append(roll_for_bonuses(rnginator(12)))
		number_of_bonuses -= 1
	while number_of_drawbacks != 0:
		keywords.append(roll_for_drawbacks(rnginator(6)))
		number_of_drawbacks -= 1
	return { "Damage" : damage,
			 "Health" : health,
			 "Keywords" : keywords }
	
	
func roll_for_bonuses(bonuses_roll_result):
	match bonuses_roll_result:
		1,2,3:
			if card["Secondary Affinity"] != "None":
				var possible_keywords : Array = []
				possible_keywords.append_array(bonus_keywords_by_affinity[card["Primary Affinity"]])
				possible_keywords.append_array(bonus_keywords_by_affinity[card["Secondary Affinity"]])
				return possible_keywords.pick_random()
			else:
				return bonus_keywords_by_affinity[card["Primary Affinity"]].pick_random()
		4,5,6:
			if card["Secondary Soul Type"] != "None":
				var possible_keywords : Array = []
				possible_keywords.append_array(bonus_keywords_by_soul_type[card["Primary Soul Type"]])
				possible_keywords.append_array(bonus_keywords_by_soul_type[card["Secondary Soul Type"]])
				return possible_keywords.pick_random()
			else:
				return bonus_keywords_by_soul_type[card["Primary Soul Type"]].pick_random()
		7:
			return "Large"
		8:
			return "Quick"
		9:
			return "Lunge"
		10:
			return "Mobile"
		11:
			return "Guard"
		12:
			return "Charge"
	
	
func roll_for_drawbacks(drawbacks_roll_result):
	match drawbacks_roll_result:
		1,2,3,4,5:
			if card["Secondary Affinity"] != "None":
				var possible_keywords : Array = []
				possible_keywords.append_array(drawback_keywords_by_affinity[card["Primary Affinity"]])
				possible_keywords.append_array(drawback_keywords_by_affinity[card["Secondary Affinity"]])
				return possible_keywords.pick_random()
			else:
				return drawback_keywords_by_affinity[card["Primary Affinity"]].pick_random()
		6:
			return "Traitorous"


func roll_for_advanced_bonuses(advanced_roll_result):
	match advanced_roll_result:
		1,2:
			if card["Secondary Affinity"] != "None":
				var possible_keywords : Array = []
				possible_keywords.append_array(advanced_bonus_keywords_by_affinity[card["Primary Affinity"]])
				possible_keywords.append_array(advanced_bonus_keywords_by_affinity[card["Secondary Affinity"]])
				return possible_keywords.pick_random()
			else:
				return advanced_bonus_keywords_by_affinity[card["Primary Affinity"]].pick_random()
		3,4:
			if card["Secondary Affinity"] != "None":
				var possible_keywords : Array = []
				possible_keywords.append_array(advanced_bonus_keywords_by_soul_type[card["Primary Affinity"]])
				possible_keywords.append_array(advanced_bonus_keywords_by_soul_type[card["Secondary Affinity"]])
				return possible_keywords.pick_random()
			else:
				return advanced_bonus_keywords_by_soul_type[card["Primary Affinity"]].pick_random()
		5:
			return "Fury"
		6:
			return "Ranged"
		7:
			return "Double"
		8:
			return "Cleave"

