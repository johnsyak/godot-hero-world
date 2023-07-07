extends CharacterBody2D

@export var speed = 25
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D
@onready var player = get_tree().get_nodes_in_group("player_group")[0]


func _ready():
	pass
	
func updateVelocity():
	velocity = (player.position - position).normalized() * speed

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
