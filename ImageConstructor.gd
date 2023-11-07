extends Node

var cardFront = Image.load_from_file("res://textures/CardFront.png")
var cardBack = Image.load_from_file("res://textures/CardBack.png")

var cardCount = 36

var cardHeight = 717
var cardWidth = 512

# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateCard()
	pass


func GenerateCard():
	var outputImage = Image.create((cardWidth*10),(cardHeight*((clampi((roundf(cardCount/10)),0,10))+1)),false, Image.FORMAT_RGBA8)
	
	for i in cardCount:
		
		outputImage.blit_rect(cardFront,Rect2(0,0,512,717),Vector2((i-((roundf(i/10)*10)))*512,(roundf((i/10))*717)))
	
	outputImage.save_png("res://textures/CardGrid.png")
	return outputImage
