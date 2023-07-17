extends CanvasLayer

const WORLD = ("res://scenes/world.tscn")
const BUILDING = ("res://scenes/building.tscn")

func _ready():
	hide_elements()

func change_stage(stage_path, spawn_position: Vector2):
	show_elements()
	get_node("FadeAnim").play("fade_in")
	await get_node("FadeAnim").animation_finished
	set_player_position(stage_path, spawn_position)
	hide_elements()

	
func hide_elements():
	get_node("ColorRect").hide()
	get_node("Label").hide()

func show_elements():
	get_node("ColorRect").show()
	get_node("Label").show()

func set_player_position(stage_path, player_position):
	get_tree().change_scene_to_file(stage_path)
	

