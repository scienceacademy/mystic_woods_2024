extends StaticBody2D


func _on_area_2d_body_entered(body):
	if body is Player:
		$Sprite2D.modulate.a = 0.7

func _on_area_2d_body_exited(body):
	if body is Player:
		$Sprite2D.modulate.a = 1.0
