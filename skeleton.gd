extends CharacterBody2D
class_name Skeleton

@export var walk_speed = 50
enum states {IDLE, CHASE, ATTACK, HURT, DEAD}
var state = states.IDLE
var prev_state = states.IDLE
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
			#if not player in $Attack.get_overlapping_bodies():
				#state = states.CHASE
		states.HURT:
			pass
		states.DEAD:
			$AnimationPlayer.play("death")
			set_physics_process(false)
			$CollisionShape2D.disabled = true
		
func _on_detect_body_entered(body):
	player = body
	state = states.CHASE
	
func _on_detect_body_exited(body):
	player = null
	state = states.IDLE
	
func _on_attack_body_entered(body):
	state = states.ATTACK
	
func _on_attack_body_exited(body):
	if state == states.HURT:
		prev_state = states.CHASE
		return
	state = states.CHASE
	
func hurt(amount, dir):
	if state == states.HURT:
		return
	$AnimationPlayer.play("hurt")
	health -= amount
	prev_state = state
	state = states.HURT
	velocity = dir * 50
	await get_tree().create_timer(.4).timeout
	state = prev_state
	if health <= 0:
		state = states.DEAD
