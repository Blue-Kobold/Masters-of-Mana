extends Node

@export var cardCount : int = 60

var cardFront = Image.load_from_file("res://textures/CardFront.png")
var cardBack = Image.load_from_file("res://textures/CardBack.png")

var cardHeight = cardFront.get_height()
var cardWidth = cardFront.get_width()

class ImageWithData:
	var img
	var cardWidth
	var cardHeight

# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateCard(10)
	pass


func GenerateCard(cardCount):
	var outputImage = Image.create((cardWidth*10),(cardHeight*((clampi((roundf(cardCount/10)),0,10))+1)),false, Image.FORMAT_RGBA8)
	
	for i in cardCount:
		
		outputImage.blit_rect(cardFront,Rect2(0,0,cardWidth,cardHeight),Vector2((i-((roundf(i/10)*10)))*cardWidth,(roundf((i/10))*cardHeight)))
	
	var outputData = ImageWithData.new()
	outputData.img = outputImage
	outputData.cardWidth = 10
	outputData.cardHeight = ((clampi((roundf(cardCount/10)),0,10))+1)
	
	#outputImage.save_png("res://textures/CardGrid.png")
	return outputData
