extends Node2D
export (PackedScene) var CombatTutorial_scene
   
func enter():
	print("enter house")
	get_tree().change_scene(CombatTutorial_scene.resource_path)
	pass

func _on_Doorway_body_entered(body):
	body.house = self


func _on_Doorway_body_exited(body):
	if body.house == self:
		body.house = null
	
