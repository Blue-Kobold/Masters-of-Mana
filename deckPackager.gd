extends Node2D

var deck = load(("res://Deck.gd"))
var card = load("res://Card.gd")
var imgcon = load("res://ImageConstructor.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	CreateDeck()
	pass # Replace with function body.

func CreateDeck():
	
	var deckName = "TestDeckOfCards"
	var targetDeck = deck.CustomDeck.new()
	
	
	targetDeck.faceURL = imgcon.GenerateCard()
	targetDeck.backURL = "res://textures/CardBack.png"
	
	var DeckDictionary = {
		"Name": "DeckCustom",
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
		"Nickname": "This is some fuckery",
		"Description": "but its kinda magic innit",
		  "ObjectStates": []
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
		"CardID": 696900
		}
	
	var lmao = ObjectDictionaryTemplate.duplicate()
	lmao["Name"] = "fuck"
	var lmoa = ObjectDictionaryTemplate.duplicate()
	lmoa["Name"] = "shit"
	var lmee = ObjectDictionaryTemplate.duplicate()
	lmee["Name"] = "darn"
	
	var collectionofObjects = [lmao,lmoa,lmee]
	DeckDictionary["ObjectStates"] = collectionofObjects
	
	
	if DirAccess.dir_exists_absolute("res://" + deckName) != true:
		
		var _dir = DirAccess.make_dir_absolute("res://" + deckName)
	
	var outputFile = FileAccess.open(("res://"+ deckName +"//CardGrid.json"),FileAccess.WRITE)
	
	outputFile.store_string(JSON.stringify(DeckDictionary,"   "))
	
	pass
