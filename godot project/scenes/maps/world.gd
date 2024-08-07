extends Node2D

@onready var hearts_container = $CanvasLayer/hearts_container
@onready var player  = get_tree().get_nodes_in_group("player_group")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_container.set_max_hearts(player.MAX_HEALTH)
	hearts_container.update_hearts(player.current_health)
	player.health_changed.connect(hearts_container.update_hearts)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true
