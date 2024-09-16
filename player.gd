extends CharacterBody2D
class_name Player

@export var run_speed = 75

func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * run_speed
	move_and_slide()
	
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
