extends Area2D

@onready var parent = get_parent()
@export var velocity = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	if(parent.velocity != Vector2.ZERO):
		velocity = parent.velocity
