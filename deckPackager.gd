extends Node2D

@export var number_of_cards_to_gen : int = 3

var imgcon
var Roller = load("res://CardRoller.gd").new()
var exampleGrid

var DeckDictionary = {
	"Gravity": 0.5,
	"PlayArea": 0.5,
	"ObjectStates": [
			{
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
				"DeckIDs": [],
				"ContainedObjects": [],
			}
		]
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
	"CustomDeck":{
	},
	"Hands": true,
	"CardID": 6969,
	"GUID": "MoMFuk"
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	imgcon = $ImageConstructor
	exampleGrid = $TextureRect
	#CreateDeck(number_of_cards_to_gen)
	pass # Replace with function body.

func CreateDeck(cardCount):
	
	var preDir = "res://"
	var deckName = "TestDeckOfCards"
	var _dir 
	var CardIDSet = (RandomNumberGenerator.new().randi_range(1000,9999))
	if DirAccess.dir_exists_absolute(preDir + "/" + deckName) != true:
		
		_dir = DirAccess.make_dir_absolute(preDir + "/" + deckName)
	_dir = preDir + "/" + deckName
	
	var CardBackURL = imgcon.AddBackCard(_dir)
	
	var GeneratedCards = Roller.generate_card(cardCount)

	var collectionofObjects = []
	var cardInstance = {}
	
	for i in GeneratedCards:
		
		var index = GeneratedCards.find(i)
		
		cardInstance = ObjectDictionaryTemplate.duplicate(true)
		
		i.merge({"index" : GeneratedCards.find(i)})
		i.merge({"dir":_dir})
		i.merge({"deck Name":deckName})
		i.merge({"cardSet":CardIDSet})
		i.merge({"URL":await imgcon.GenerateSingle(i)})
		
		cardInstance["Nickname"] = str(i["Rarity"] + " " + i["Card Type"])
		cardInstance["Description"] = str(i["Primary Affinity"]) + " " + str(i["Secondary Affinity"])
		
		var cardNumber = i["cardSet"]+index
		
		cardInstance["CustomDeck"].merge({cardNumber:{}})
		cardInstance["CustomDeck"][cardNumber].merge({"FaceURL":i["URL"]})
		cardInstance["CustomDeck"][cardNumber].merge({"BackURL":CardBackURL})
		cardInstance["CustomDeck"][cardNumber].merge({"NumWidth":1})
		cardInstance["CustomDeck"][cardNumber].merge({"NumHeight":1})
		cardInstance["CustomDeck"][cardNumber].merge({"BackIsHidden":true})
		cardInstance["CustomDeck"][cardNumber].merge({"UniqueBack":false})
		cardInstance["CustomDeck"][cardNumber].merge({"Type":0})
		
		cardInstance["CardID"] = cardNumber*100
		cardInstance["GUID"] = cardInstance["GUID"] + str(index)
		DeckDictionary["ObjectStates"][0]["DeckIDs"].append(cardInstance["CardID"])
		collectionofObjects.append(cardInstance)
	
	
	DeckDictionary["ObjectStates"][0]["ContainedObjects"] = collectionofObjects
	
	
	var outputFile = FileAccess.open((_dir + "//CardGrid.json"),FileAccess.WRITE)
	
	imgcon.cardForge.queue_free()
	
	outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	
	pass


func PackageExistingCards(ExistingCards):
	var preDir = "res://"
	var deckName = "TestDeckOfCards"
	var _dir 
	var CardIDSet = (RandomNumberGenerator.new().randi_range(1000,9999))
	if DirAccess.dir_exists_absolute(preDir + "/" + deckName) != true:
		
		_dir = DirAccess.make_dir_absolute(preDir + "/" + deckName)
	_dir = preDir + "/" + deckName
	
	var CardBackURL = imgcon.AddBackCard(_dir)

	var collectionofObjects = []
	var cardInstance = {}
	
	for i in ExistingCards:
		
		var index = ExistingCards.find(i)
		
		cardInstance = ObjectDictionaryTemplate.duplicate(true)
		
		i.merge({"index" : ExistingCards.find(i)})
		i.merge({"dir":_dir})
		i.merge({"deck Name":deckName})
		i.merge({"cardSet":CardIDSet})
		i.merge({"URL":await imgcon.GenerateSingle(i)})
		
		cardInstance["Nickname"] = str(i["Rarity"] + " " + i["Card Type"])
		cardInstance["Description"] = str(i["Primary Affinity"]) + " " + str(i["Secondary Affinity"])
		
		var cardNumber = i["cardSet"]+index
		
		cardInstance["CustomDeck"].merge({cardNumber:{}})
		cardInstance["CustomDeck"][cardNumber].merge({"FaceURL":i["URL"]})
		cardInstance["CustomDeck"][cardNumber].merge({"BackURL":CardBackURL})
		cardInstance["CustomDeck"][cardNumber].merge({"NumWidth":1})
		cardInstance["CustomDeck"][cardNumber].merge({"NumHeight":1})
		cardInstance["CustomDeck"][cardNumber].merge({"BackIsHidden":true})
		cardInstance["CustomDeck"][cardNumber].merge({"UniqueBack":false})
		cardInstance["CustomDeck"][cardNumber].merge({"Type":0})
		
		cardInstance["CardID"] = cardNumber*100
		cardInstance["GUID"] = cardInstance["GUID"] + str(index)
		DeckDictionary["ObjectStates"][0]["DeckIDs"].append(cardInstance["CardID"])
		collectionofObjects.append(cardInstance)
	
	
	DeckDictionary["ObjectStates"][0]["ContainedObjects"] = collectionofObjects
	
	
	var outputFile = FileAccess.open((_dir + "//CardGrid.json"),FileAccess.WRITE)
	
	imgcon.cardForge.queue_free()
	
	outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	
	pass
