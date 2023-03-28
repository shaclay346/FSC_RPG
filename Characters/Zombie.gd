extends KinematicBody2D

var speed = 75
var motion = Vector2.ZERO
var player = null

func _physics_process(delta):
	motion = Vector2.ZERO
	
	if player:
		motion = position.direction_to(player.position) * speed
		
	motion = move_and_slide(motion)


func _on_Area2D_body_entered(body):
	print("entered")
	player = body


func _on_Area2D_body_exited(body):
	print("exited")
	player = null






func _on_Area2D2_body_entered(body):
	print("sprite hit, send to fight scene")






