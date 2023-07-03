extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

var lastDirection = "Down"
var startPosition
var endPosition
var tetherPosition

var rng = RandomNumberGenerator.new()

func _ready():
	startPosition = position
	tetherPosition = position
	rng.randomize()
	var randPosX = rng.randi_range(-3, 3)
	var randPosY = rng.randi_range(-3, 3)

	endPosition = startPosition - Vector2(randPosX*16, randPosY*16)

	
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	var maxPosition = tetherPosition + Vector2(6*16, 6*16)

	if tempEnd > tetherPosition:
		tempEnd = position - Vector2(tetherPosition.x, tetherPosition.y)

	else:
		var randPosX = rng.randi_range(-2, 2)
		var randPosY = rng.randi_range(-2, 2)
		tempEnd = endPosition - Vector2(randPosX*16, randPosY*16)
	
	
	startPosition = tempEnd

func updateAnimation():
	var animationString = "walkUp"
	if velocity.y > 0:
		animationString = "walkDown"
	if velocity.x < 0:
		animationString = "walkLeft"
	if velocity.x > 0: 
		animationString = "walkRight"

	animations.play(animationString)
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
