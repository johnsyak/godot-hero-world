extends Area2D

@export var speed = 5
@export var velocity = Vector2()
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var startPosition = position
	position = startPosition - velocity * speed
