extends Area2D


func _on_body_entered(body: CharacterBody2D):
	StageManager.change_stage(StageManager.WORLD, Vector2(392, 77))

func _on_body_exited(body: CharacterBody2D):
	pass
