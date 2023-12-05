extends Node2D

@export var number_of_cards_to_gen : int = 3

var exampleGrid

var preDir = "res://"
var _dir = ""
var deckName = "TestDeckOfCards"
var CardScene = load("res://Node_template.tscn")
var Grid 

var CardIDSet

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
	#CreateDeck(number_of_cards_to_gen)
	pass # Replace with function body.

func SetDir(path):
	preDir = path

func setDeckName(val):
	deckName = val

func SetIDVal(val):
	CardIDSet = val

#func CreateDeck(cardCount):
	#
	#var _dir 
	#
	#if(CardIDSet == null):
		#CardIDSet = (RandomNumberGenerator.new().randi_range(1000,9999))
	#
	#if DirAccess.dir_exists_absolute(preDir + "/" + deckName) != true:
		#
		#_dir = DirAccess.make_dir_absolute(preDir + "/" + deckName)
	#_dir = preDir + "/" + deckName
	#
	#var CardBackURL = ImageConstructor.AddBackCard(_dir)
	#
	#var GeneratedCards = CardRoller.generate_card(cardCount)
#
	#var collectionofObjects = []
	#var cardInstance = {}
	#
	#for i in GeneratedCards:
		#
		#var index = GeneratedCards.find(i)
		#
		#
		#cardInstance = ObjectDictionaryTemplate.duplicate(true)
		#
		#i.merge({"index" : GeneratedCards.find(i)})
		#i.merge({"dir":_dir})
		#i.merge({"deck Name":deckName})
		#i.merge({"cardSet":CardIDSet})
		#i.merge({"URL":await ImageConstructor.GenerateSingle(i)})
		#
		#cardInstance["Nickname"] = str(i["Rarity"] + " " + i["Card Type"])
		#cardInstance["Description"] = str(i["Primary Affinity"]) + " " + str(i["Secondary Affinity"])
		#
		#var cardNumber = i["cardSet"]+index
		#
		#cardInstance["CustomDeck"].merge({cardNumber:{}})
		#cardInstance["CustomDeck"][cardNumber].merge({"FaceURL":i["URL"]})
		#cardInstance["CustomDeck"][cardNumber].merge({"BackURL":CardBackURL})
		#cardInstance["CustomDeck"][cardNumber].merge({"NumWidth":1})
		#cardInstance["CustomDeck"][cardNumber].merge({"NumHeight":1})
		#cardInstance["CustomDeck"][cardNumber].merge({"BackIsHidden":true})
		#cardInstance["CustomDeck"][cardNumber].merge({"UniqueBack":false})
		#cardInstance["CustomDeck"][cardNumber].merge({"Type":0})
		#
		#cardInstance["CardID"] = cardNumber*100
		#cardInstance["GUID"] = cardInstance["GUID"] + str(index)
		#DeckDictionary["ObjectStates"][0]["DeckIDs"].append(cardInstance["CardID"])
		#collectionofObjects.append(cardInstance)
		#
	#
	#
	#DeckDictionary["ObjectStates"][0]["ContainedObjects"] = collectionofObjects
	#
	#
	#var outputFile = FileAccess.open((_dir + "//CardGrid.json"),FileAccess.WRITE)
	#
	#ImageConstructor.cardForge.queue_free()
	#
	#outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	#
	#pass


func CreateDeckFromCards(UnpackedCards):
	
	if(CardIDSet == null):
		CardIDSet = (RandomNumberGenerator.new().randi_range(1000,9999))
	
	if DirAccess.dir_exists_absolute(preDir + "/" + deckName) != true:
		
		_dir = DirAccess.make_dir_absolute(preDir + "/" + deckName)
	_dir = preDir + "/" + deckName
	
	var CardBackURL = ImageConstructor.AddBackCard(_dir)

	var collectionofObjects = []
	var cardInstance = {}
	var exampleCard
	
	for i in UnpackedCards:
		
		var index = UnpackedCards.find(i)
		
		i.merge({"index" : index})
		i.merge({"dir":_dir})
		i.merge({"deck Name":deckName})
		i.merge({"cardSet":CardIDSet})
		#i.merge({"URL":await ImageConstructor.GenerateSingle(i)})
		
		collectionofObjects.append(cardInstance)
		
		exampleCard = CardScene.instantiate()
		exampleCard.SetNode(i)
		Grid = $"../UserInterface/ScrollContainer/GridContainer"
		Grid.add_child(exampleCard)
	
	#ImageConstructor.cardForge.queue_free()
	pass


func PackageEditedCards():
	DeckPackager.SetDir($"../UserInterface/MenuContainer/SelectedDir".get_text())
	DeckPackager.setDeckName($"../UserInterface/MenuContainer/DeckName".get_text())
	DeckPackager.SetIDVal($"../UserInterface/MenuContainer/SetID".get_text())
	
	print($"../ScrollContainer/GridContainer".get_child_count())
	
	if(CardIDSet == null):
		CardIDSet = (RandomNumberGenerator.new().randi_range(1000,9999))
	
	if DirAccess.dir_exists_absolute(preDir + "/" + deckName) != true:
		
		_dir = DirAccess.make_dir_absolute(preDir + "/" + deckName)
	_dir = preDir + "/" + deckName
	
	var CardBackURL = ImageConstructor.AddBackCard(_dir)

	var collectionofObjects = []
	var cardInstance = {}
	var exampleCard
	
	var EditedCardCollection = []
	for i in $"../ScrollContainer/GridContainer".get_children():
		EditedCardCollection.append(i.CardInformation)
	
	for i in EditedCardCollection:
		var index = EditedCardCollection.find(i)
		
		cardInstance = ObjectDictionaryTemplate.duplicate(true)
		
		i.merge({"index" : index})
		i.merge({"dir":_dir})
		i.merge({"deck Name":deckName})
		i.merge({"cardSet":CardIDSet})
		i.merge({"URL":await ImageConstructor.GenerateSingle(i)})
		
		cardInstance["Nickname"] = i["Name"] #Change this to the actual name value
		cardInstance["Description"] = str(i["Primary Affinity"]) + " " + str(i["Secondary Affinity"])
		
		var cardNumber = int(i["cardSet"])+index
		
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
	
	ImageConstructor.cardForge.queue_free()
	
	outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	

func _on_button_2_pressed():
	PackageEditedCards()
	pass # Replace with function body.
