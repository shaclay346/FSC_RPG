extends Node2D
var outside = "res://Scenes/Tutorial Level.gd"
var entered = false





func _on_Exit_body_entered(body):
	if entered:
		get_tree().change_scene("res://Scenes/Tutorial Level.tscn")


func _on_Exit_body_exited(body):
	entered = true
