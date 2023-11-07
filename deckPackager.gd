extends Node2D


@export var number_of_cards_to_gen : int = 100

var deck = load(("res://Deck.gd"))
var card = load("res://Card.gd")
var imgcon = load("res://ImageConstructor.gd").new()
var Roller = load("res://CardRoller.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	CreateDeck(number_of_cards_to_gen)
	pass # Replace with function body.

func CreateDeck(cardCount):
	
	var deckName = "TestDeckOfCards"
	
	var GeneratedCards = Roller.generate_card(cardCount)
	
		
	var DeckDictionary = {
		"Gravity": 0.5,
		"PlayArea": 0.5,
		"ObjectStates": [{
			"Name": "DeckCustom",
			"Transform": {
				"posX": 0,
				"posY": 0.0,
				"posZ": 0,
				"rotX": 180,
				"rotY": 180.0,
				"rotZ": 0,
				"scaleX": 1.0,
				"scaleY": 1.0,
				"scaleZ": 1.0
				},
			"CustomDeck": {
					"6969": {
						"FaceURL": "",
						"BackURL": "",
						"NumWidth": 5,
						"NumHeight": 5,
						"BackIsHidden": false,
						"UniqueBack": false,
						"Type": 0
						}
					},
			"DeckIDs": [],
			"ContainedObjects": [],
			}]
		}
	
	var ObjectDictionaryTemplate = {
		"Name": "Card",
		"Transform": {
			"posX": 0,
			"posY": 0.0,
			"posZ": 0,
			"rotX": 0,
			"rotY": 180.0,
			"rotZ": 0,
			"scaleX": 1.0,
			"scaleY": 1.0,
			"scaleZ": 1.0
			},
		"Nickname": "",
		"Description": "",
		"Hands": true,
		"CardID": 6969,
		"GUID": "MoMFuk"
		}
	
	var collectionofObjects = []
	
	for i in GeneratedCards.size():
		print("WOOOOOOOOoooooooo " + str(GeneratedCards[i]))
		var cardInstance = ObjectDictionaryTemplate.duplicate()
		var Transfer = GeneratedCards[i]
		cardInstance["Nickname"] = str(Transfer["Card Type"])
		cardInstance["Description"] = str(Transfer["Primary Affinity"]) + " " + str(Transfer["Secondary Affinity"])
		cardInstance["CardID"] = (6969*100)+i
		cardInstance["GUID"] = cardInstance["GUID"] + str(i)
		DeckDictionary["ObjectStates"][0]["DeckIDs"].append(cardInstance["CardID"])
		collectionofObjects.append(cardInstance)
	
	var CardCollection = imgcon.GenerateCard(cardCount)
	var ccString = "res://"+ deckName +"//CardGrid.png"
	ccString = "C:\\Users\\Taelin\\Documents\\My Games\\Tabletop Simulator\\Saves\\Saved Objects\\MOM Testing Grounds\\Active Testing"+"//CardGrid.png"
	CardCollection.img.save_png(ccString)
	
	DeckDictionary["ObjectStates"][0]["CustomDeck"]["6969"]["FaceURL"] = ccString
	DeckDictionary["ObjectStates"][0]["CustomDeck"]["6969"]["BackURL"] = "C:\\Users\\Taelin\\Documents\\My Games\\Tabletop Simulator\\Saves\\Saved Objects\\MOM Testing Grounds\\Active Testing" + "//CardBack.png"
	DeckDictionary["ObjectStates"][0]["CustomDeck"]["6969"]["NumHeight"] = CardCollection.cardHeight
	DeckDictionary["ObjectStates"][0]["CustomDeck"]["6969"]["NumWidth"] = CardCollection.cardWidth
	
	DeckDictionary["ObjectStates"][0]["ContainedObjects"] = collectionofObjects
	
	
	if DirAccess.dir_exists_absolute("res://" + deckName) != true:
		
		var _dir = DirAccess.make_dir_absolute("res://" + deckName)
	
	#var outputFile = FileAccess.open(("res://"+ deckName +"//CardGrid.json"),FileAccess.WRITE)
	var outputFile = FileAccess.open(("C:\\Users\\Taelin\\Documents\\My Games\\Tabletop Simulator\\Saves\\Saved Objects\\MOM Testing Grounds\\Active Testing"+"//CardGrid.json"),FileAccess.WRITE)
	
	outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	
	pass
