extends Node2D

@export var cardCount : int = 60

var cardFront = Image.load_from_file("res://textures/CardComponents/card_background_for_color_shifting_empty.png")
var cardBack = Image.load_from_file("res://textures/CardComponents/masters_of_mana_cardback_v1.png")

var trinketPlate = Image.load_from_file("res://textures/CardComponents/card_metal_for_trinket.png")
var wonderousPlate = Image.load_from_file("res://textures/CardComponents/card_metal_for_wondrous.png")
var ascendantPlate = Image.load_from_file("res://textures/CardComponents/card_metal_for_ascendant.png")
var relicPlate = Image.load_from_file("res://textures/CardComponents/cardfront_relic3.png")

var manapip1 = Image.load_from_file("res://textures/CardComponents/1_slot.png")
var manapip2 = Image.load_from_file("res://textures/CardComponents/2_slot.png")
var manapip3 = Image.load_from_file("res://textures/CardComponents/3_slot.png")

var cardHeight = cardFront.get_height()
var cardWidth = cardFront.get_width()

var cardScene = preload("res://card_template.tscn")

var cardForge
var frgBack
var frgctx
var frgPlate
var frgPips
var frgScrews
var frgSet
var frgTitle
var frgText
var frgRules
var frgPow
var frgGrd
var frgOutCtx

class ImageWithData:
	var individualCards = []
	var fullCardGrid
	var cardWidth
	var cardHeight

# Called when the node enters the scene tree for the first time.
func _ready():
	#OpenCardForge()
	pass

func OpenCardForge():
	
	if cardForge != null:
		return
	
	get_viewport().set_embedding_subwindows(false)
	cardForge = cardScene.instantiate()
	add_child(cardForge)
	frgctx = cardForge.get_child(0)
	frgBack = cardForge.get_child(1)
	frgPlate = cardForge.get_child(2)
	frgPips = cardForge.get_child(3)
	frgScrews = cardForge.get_child(4)
	frgSet = cardForge.get_child(5)
	frgTitle = cardForge.get_child(6).get_child(0)
	frgText = cardForge.get_child(7).get_child(0)
	frgRules = cardForge.get_child(8).get_child(0)
	frgPow = cardForge.get_child(9).get_child(0)
	frgGrd = cardForge.get_child(10).get_child(0)
	frgOutCtx = cardForge.get_child(11)
	
	cardForge.visible = true
	cardForge.position = Vector2(6000,45)
	cardForge.title = "Card Smithin'"
	cardForge.size = Vector2i(cardWidth, cardHeight)
	
	await get_tree().create_timer(0.5).timeout

func AddBackCard(path):
	if DirAccess.dir_exists_absolute(path+"/GeneratedCards") != true:
		
		DirAccess.make_dir_absolute(path+"/GeneratedCards")
	
	var outPath = path + "/GeneratedCards/CardBack.png"
	cardBack.save_png(outPath)
	return outPath

func GenerateSingle(targetCard):
	
	OpenCardForge()
	
	cardForge.title = "Smithin' card number " + str(targetCard["index"])
	if targetCard["URL"] != "":
		frgctx.texture = ImageTexture.create_from_image(targetCard["URL"])
	if targetCard["OverURL"] != "":
		frgOutCtx.texture = ImageTexture.create_from_image(targetCard["OverURL"])
	
	frgBack.texture = ImageTexture.create_from_image(cardFront)
	
	match(targetCard["Primary Affinity"]):
		#                               Color(R,G,B,A)
		"Mind":
			frgBack.self_modulate = Color(3,3,3,1)
		"Ambition":
			frgBack.self_modulate= Color(10,2,2,1)
		"Chaos":
			frgBack.self_modulate = Color(2,2,2,1)
		"Order":
			frgBack.self_modulate = Color(10,10,10,1)
		"Nature":
			frgBack.self_modulate = Color(2,10,2,1)
		"Spirit":
			frgBack.self_modulate = Color(2,2,10,1)
		"None":
			frgBack.self_modulate = Color(50,50,50,1)
	
	match(targetCard["Rarity"]):
		"Trinket":
			frgPlate.texture = ImageTexture.create_from_image(trinketPlate)
		"Wondrous":
			frgPlate.texture = ImageTexture.create_from_image(wonderousPlate)
		"Ascendant":
			frgPlate.texture = ImageTexture.create_from_image(ascendantPlate)
		"Relic":
			frgPlate.texture = ImageTexture.create_from_image(relicPlate)
	
	match(targetCard["Mana Cost"]):
		1:
			frgPips.texture = ImageTexture.create_from_image(manapip1)
		2:
			frgPips.texture = ImageTexture.create_from_image(manapip2)
		3:
			frgPips.texture = ImageTexture.create_from_image(manapip3)
	
	
	var titleStr = targetCard["Name"]
	var textStr = targetCard["Primary Affinity"] + "-" + targetCard["Secondary Affinity"]
	var rulesStr = ""
	var powStr = ""
	var grdStr = ""
	
	if targetCard.has("Damage"):
		powStr = "Power:" + str(targetCard["Damage"])
	
	if targetCard.has("Health"):
		grdStr = "Health:" + str(targetCard["Health"])
	
	for i in  targetCard["Keywords"]:
		rulesStr += i + "\n"
	
	frgTitle.text = titleStr
	frgText.text = textStr
	frgRules.text = rulesStr
	frgPow.text = powStr
	frgGrd.text = grdStr
	
	var waitTime = 0.2
	
	var cardPath = targetCard["dir"]+"/GeneratedCards/"+ titleStr + " " + textStr + " " + str(targetCard["index"]) +".png"
	
	await get_tree().create_timer(waitTime).timeout
	cardForge.get_viewport().get_texture().get_image().save_png(cardPath)
	await get_tree().create_timer(waitTime).timeout
	
	frgTitle.text = "Blank Card"
	frgText.text = "Blank Desc"
	
	
	return cardPath


func GenerateCardCollection(cardCollection):
	
	await OpenCardForge()
	
	
	var outputData = ImageWithData.new()
	var outputImage = Image.create((cardWidth*9),(cardHeight*((clampi((roundf(cardCount/9)),0,9))+1)),false, Image.FORMAT_RGBAF)
	
	var bufImg
	var bufCardWidth
	var bufCardheight
	#for i in cardCollection:
#
		#bufImg = await GenerateSingle(i, cardCollection.find(i))
		#outputData.individualCards.append(bufImg)
	
	for i in outputData.individualCards.size():
		
		bufImg = Image.load_from_file(outputData.individualCards[i])
		bufCardWidth = ((i-((roundf(i/9)*9)))*cardWidth)
		bufCardheight = (roundf((i/10))*cardHeight)
		#print("w:" + str(bufImg.data["height"]) + " h:" + str(bufImg.data["height"]))
		outputImage.blit_rect(bufImg,Rect2(0,0,cardWidth,cardHeight),Vector2(bufCardWidth,bufCardheight))
		
	
	
	outputData.fullCardGrid = outputImage
	outputData.cardWidth = 9
	outputData.cardHeight = ((clampi((roundf(cardCollection.size()/9)),0,9))+1)
	
	cardForge.queue_free()
	
	#outputImage.save_png("res://textures/CardGrid.png")
	return outputData
