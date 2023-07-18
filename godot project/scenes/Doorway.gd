extends Area2D



func _on_body_entered(body: CharacterBody2D):
	StageManager.change_stage(StageManager.BUILDING, Vector2(72, 110))

func _on_body_exited(body: CharacterBody2D):
	pass
