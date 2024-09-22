extends CharacterBody2D
class_name Player

@export var run_speed = 75
var attacking = false

func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * run_speed
	if attacking:
		velocity = Vector2.ZERO
		return
	move_and_slide()
	
	if velocity.x != 0:
		transform.x.x = sign(velocity.x)
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
		
func _input(event):
	if event.is_action_pressed("attack"):
		attack()
		
func attack():
		$AnimationPlayer.play("attack")
		attacking = true
		await $AnimationPlayer.animation_finished
		attacking = false


func _on_hurtbox_body_entered(body):
	body.hurt(1, position.direction_to(body.position))
