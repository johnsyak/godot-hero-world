extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition

var rng = RandomNumberGenerator.new()

func _ready():
	startPosition = position
	print("startPositionX:" + str(startPosition.x).pad_decimals(5) + " , startPositionY:" + str(startPosition.y).pad_decimals(5) )
	rng.randomize()
	var randPosX = rng.randi_range(-3, 3)
	var randPosY = rng.randi_range(-3, 3)
	print("X:" + str(randPosX))
	print("Y:"+str(randPosY))
	endPosition = startPosition + Vector2(randPosX*16, randPosY*16)

	
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateAnimation():
	var animationString = "walkUp"
	if velocity.y > 0:
		animationString = "walkDown"

	animations.play(animationString)
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
