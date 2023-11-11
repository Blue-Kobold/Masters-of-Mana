extends Node2D

@export var cardCount : int = 60

var cardFront = Image.load_from_file("res://textures/CardComponents/masters_of_mana_cardfront_v0.6.png")
var cardBack = Image.load_from_file("res://textures/CardComponents/masters_of_mana_cardback_v1.png")

var cardHeight = cardFront.get_height()
var cardWidth = cardFront.get_width()

var cardBase = Image.load_from_file("res://textures/CardComponents/CardBase.png")


var cardScene = preload("res://card_template.tscn")

var cardForge
var frgImg
var frgTitle
var frgText

class ImageWithData:
	var individualCards = []
	var fullCardGrid
	var cardWidth
	var cardHeight

# Called when the node enters the scene tree for the first time.
func _ready():
	OpenCardForge()
	pass

func OpenCardForge():
	
	if cardForge != null:
		return
	
	get_viewport().set_embedding_subwindows(false)
	cardForge = cardScene.instantiate()
	add_child(cardForge)
	frgImg = cardForge.get_child(0)
	frgTitle = cardForge.get_child(1).get_child(0)
	frgText = cardForge.get_child(2).get_child(0)
	
	cardForge.visible = true
	cardForge.position = Vector2(6000,45)
	cardForge.title = "Card Smithin'"
	cardForge.size = Vector2i(cardWidth, cardHeight)
	
	await get_tree().create_timer(0.5).timeout

func GenerateSingle(targetCard, count):
	
	frgImg.texture = ImageTexture.new().create_from_image(cardBase)
	
	frgTitle.text = targetCard["Rarity"] + " " + targetCard["Card Type"]
	frgText.text = targetCard["Primary Affinity"] + " " + targetCard["Secondary Affinity"]
	
	var waitTime = 0.05
	
	await get_tree().create_timer(waitTime).timeout
	cardForge.get_viewport().get_texture().get_image().save_png("res://textures/GeneratedCards/"+ frgTitle.text + str(count) +".png")
	var returningImageStr = "res://textures/CardComponents/"+ frgTitle.text +".png"
	await get_tree().create_timer(waitTime).timeout
	
	frgTitle.text = "Blank Card"
	frgText.text = "Blank Desc"
	
	
	return returningImageStr


func GenerateCardCollection(cardCollection):
	
	await OpenCardForge()
	
	var outputData = ImageWithData.new()
	var outputImage = Image.create((cardWidth*9),(cardHeight*((clampi((roundf(cardCount/9)),0,9))+1)),false, Image.FORMAT_RGBA8)
	
	var bufImg
	var bufCardWidth
	var bufCardheight
	for i in cardCollection:
		
		bufImg = await GenerateSingle(i, cardCollection.find(i))
		outputData.individualCards.append(bufImg)
	
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
