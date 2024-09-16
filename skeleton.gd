extends CharacterBody2D
class_name Skeleton

@export var walk_speed = 50
enum states {IDLE, CHASE, ATTACK, HURT, DEAD}
var state = states.IDLE
var player
var health = 3

func _physics_process(delta):
	choose_action()
	move_and_slide()
	
func choose_action():
	$Label.text = states.keys()[state]
	match state:
		states.IDLE:
			$AnimationPlayer.play("idle")
			velocity = Vector2.ZERO
		states.CHASE:
			$AnimationPlayer.play("run")
			velocity = position.direction_to(player.position) * walk_speed
			if velocity.x != 0:
				transform.x.x = sign(velocity.x)
		states.ATTACK:
			velocity = Vector2.ZERO
			$AnimationPlayer.play("attack")

func _on_detect_body_entered(body):
	player = body
	state = states.CHASE
	
func _on_detect_body_exited(body):
	player = null
	state = states.IDLE
	
func _on_attack_body_entered(body):
	state = states.ATTACK
	
func _on_attack_body_exited(body):
	state = states.CHASE
