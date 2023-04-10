extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	display_text("now entering Mr. Georges Green! ")


func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")
		
func display_text(text):
	$Textbox.show()
	$Textbox/MarginContainer/Panel/middle.text = text
