extends Node2D

@onready var hearts_container = $CanvasLayer/hearts_container
@onready var player  = $TileMap/player

# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_container.setMaxHearts(player.max_health)
	hearts_container.updateHearts(player.current_health)
	player.health_changed.connect(hearts_container.update_hearts)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
