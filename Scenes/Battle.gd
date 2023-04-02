extends Control

signal textbox_closed


# Called when the node enters the scene tree for the first time.
func _ready():
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("An enemy appears!")
	yield(self, "textbox_closed")
	$ActionsPanel.show()
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")
		
func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text


func _on_Run_pressed():
	display_text("You got away safely!")
	yield(self, "textbox_closed")
#	#timer so we don't close the screen immediatly 
	yield(get_tree().create_timer(0.25), "timeout")
#	use this to exit the scene when player escapes from fight
	get_tree().quit()
