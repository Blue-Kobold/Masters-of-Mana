class CustomDeck:
	var faceURL = ""
	var backURL = ""
	var numWidth = 0
	var numHeight = 0
	var backIsHidden = true
	var uniqueBack = false
	var type = 0


func _init(value):
	CustomDeck.new().FaceURL = value
