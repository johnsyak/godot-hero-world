extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimationPlayer

var startPosition
var endPosition

func _ready():
	pass
	
#func changeDirection():
	#var tempEnd = endPosition
	#endPosition = startPosition
	#startPosition = tempEnd
	
#func updateVelocity():
	#var moveDirection = (endPosition - position)
	#if moveDirection.length() < limit:
		#changeDirection()
		
	#velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "_down"
		if velocity.x < 0: direction = "_left"
		elif velocity.x > 0: direction = "_right"
		elif velocity.y < 0:direction = "_up"
		
		animations.play("walk"+direction)
		
func _physics_process(delta):
	#updateVelocity()
	move_and_slide()
	updateAnimation()
	

	
