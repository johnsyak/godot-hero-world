extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5
@export var tetherMax = 5

@onready var animations = $AnimatedSprite2D

var tetherPos
var startPos
var endPos

var rng = RandomNumberGenerator.new()

func _ready():
	tetherPos = position
	startPos = tetherPos
	endPos = startPos + Vector2(0, 3*16)
	rng.randomize()
	var randPosX = rng.randi_range(-3, 3)
	var randPosY = rng.randi_range(-3, 3)

	endPos = startPos - Vector2(randPosX*16, randPosY*16)

func updateVelocity():
	var moveDirection = endPos - position

	if moveDirection.length() < limit:
		position = endPos
		changeDirection()
	
	velocity = moveDirection.normalized()*speed
	
func changeDirection():
	var tempEnd = endPos
	endPos = startPos
	if(startPos.x > 0 and startPos.x > (tetherPos.x + tetherMax)):
		startPos = tempEnd + Vector2(4*16, 0)
	elif(startPos.x < 0 and startPos.x < (tetherPos.x + -tetherMax)):
		startPos = tempEnd - Vector2(4*16, 0)
	elif(startPos.y < 0 and startPos.y < (tetherPos.y + -tetherMax)):
		startPos = tempEnd - Vector2(0, 4*16)
	elif(startPos.y > 0 and startPos.y > (tetherPos.y + tetherMax)):
		startPos = tempEnd + Vector2(0, 4*16)
	else:
		var randPosX = rng.randi_range(-2, 2)
		var randPosY = rng.randi_range(-2, 2)
		startPos = tempEnd - Vector2(randPosX*16, randPosY*16)

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
