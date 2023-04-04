extends KinematicBody2D

var speed = 75
var motion = Vector2.ZERO
var player = null
var counter = 0

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
	counter += 1
	
	if(counter == 2):
		yield(get_tree().create_timer(0.3), "timeout")
		get_tree().change_scene("res://Scenes/Battle.tscn")






