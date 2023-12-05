extends Control

var CardInformation

var Name = "Card"
var cardUnderImg
var cardOverImg #Generally Blank lmao
var Rarity
var PrimeAffinity
var SubAffinity
var ManaCost
var Nickname = ""
var TypeText = ""
var Description = ""
var PowerVal = 0
var DefenseVal = 0
var Keywords = []
var CardID = ""

var FileBox

func SetNode(Val):
	CardInformation = Val
	
	
	CardInformation.merge({"URL":""}) 
	CardInformation.merge({"OverURL":""}) 
	
	$NameText.text = Val["Primary Affinity"] + " " + Val["Secondary Affinity"]
	CardInformation["Name"] = $NameText.text
	
	PrimeAffinity = Val["Primary Affinity"]
	SubAffinity = Val["Secondary Affinity"]
	match(Val["Primary Affinity"]):
		#                               Color(R,G,B,A)
		"Mind":
			$CardBase2.self_modulate = Color(3,3,3,1)
		"Ambition":
			$CardBase2.self_modulate= Color(10,2,2,1)
		"Chaos":
			$CardBase2.self_modulate = Color(2,2,2,1)
		"Order":
			$CardBase2.self_modulate = Color(10,10,10,1)
		"Nature":
			$CardBase2.self_modulate = Color(2,10,2,1)
		"Spirit":
			$CardBase2.self_modulate = Color(2,2,10,1)
		"None":
			$CardBase2.self_modulate = Color(50,50,50,1)
	
	Rarity = Val["Rarity"]
	match(Val["Rarity"]):
		"Trinket":
			$Plate2.texture = ImageTexture.create_from_image(ImageConstructor.trinketPlate)
		"Wondrous":
			$Plate2.texture = ImageTexture.create_from_image(ImageConstructor.wonderousPlate)
		"Ascendant":
			$Plate2.texture = ImageTexture.create_from_image(ImageConstructor.ascendantPlate)
		"Relic":
			$Plate2.texture = ImageTexture.create_from_image(ImageConstructor.relicPlate)
	
	ManaCost = Val["Mana Cost"]
	match(Val["Mana Cost"]):
		1:
			$Pips2.texture = ImageTexture.create_from_image(ImageConstructor.manapip1)
		2:
			$Pips2.texture = ImageTexture.create_from_image(ImageConstructor.manapip2)
		3:
			$Pips2.texture = ImageTexture.create_from_image(ImageConstructor.manapip3)
	
	TypeText = Val["Card Type"]
	$TypeText.text = Val["Card Type"]
	
	PowerVal = Val["Damage"]
	$PowerText.text = str(Val["Damage"])
	
	DefenseVal = Val["Health"]
	$DefenseText.text = str(Val["Health"])
	
	
	var BufferText = ""
	for i in  Val["Keywords"]:
		Keywords.append(i)
		BufferText += i + "\n"
	$RulesText.text = BufferText
	
	pass

func _on_inner_image_button_pressed():
	if !FileBox:
		FileBox = FileDialog.new()
		add_child(FileBox)
		FileBox.popup_centered(Vector2i(500,500))
	
	FileBox.connect("file_selected", _AssignInnerImage)
	pass # Replace with function body.

func _AssignInnerImage(val):
	cardUnderImg = val
	CardInformation.merge({"URL":val})
	$InnerCardContent.texture = ImageTexture.create_from_image(Image.load_from_file(val))
	FileBox = null
	pass

func _on_outer_image_button_pressed():
	if !FileBox:
		FileBox = FileDialog.new()
		add_child(FileBox)
		FileBox.popup_centered(Vector2i(500,500))
	
	FileBox.connect("file_selected", _AssignOuterImage)
	pass # Replace with function body.

func _AssignOuterImage(val):
	cardOverImg = val
	CardInformation.merge({"OverURL":val}) 
	$OuterCardContent.texture = ImageTexture.create_from_image(Image.load_from_file(val))
	FileBox = null
	pass


func _on_name_text_text_changed(str):
	Name = str
	CardInformation["Name"] = str
	pass # Replace with function body.
