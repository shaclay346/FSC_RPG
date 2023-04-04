extends Control

signal textbox_closed

var current_player_health = 0
var current_enemy_health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	set_health($EnemyContainer/ProgressBar, BaseEnemy.health, BaseEnemy.health)
	set_health($EnemyContainer/ProgressBar, BaseEnemy.health, BaseEnemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	
	current_player_health = State.current_health
	current_enemy_health = BaseEnemy.health
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("A zombie approaches!")
	yield(self, "textbox_closed")
	$ActionsPanel.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]



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

func enemy_turn():
	display_text("%s launches at you!" % [BaseEnemy.name])
	yield(self, "textbox_closed")
	
	
	current_player_health = max(0, current_player_health - BaseEnemy.damage)
	set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	
	$AnimationPlayer.play("Player Damage Shake")
	yield($AnimationPlayer, "animation_finished")
	
	display_text("Enemy dealt %d damage" % [State.damage])
	yield(self, "textbox_closed")
	

func _on_Attack_pressed(weapon="sword"):
#	%d/%d" % [health, max_health]
	display_text("you swing your %s" % [weapon])
	yield(self, "textbox_closed")
	
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, BaseEnemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	
	display_text("You dealt %d damage" % [State.damage])
	yield(self, "textbox_closed")
	
	if(current_enemy_health > 0):
		enemy_turn()
	else:
		display_text("The %s was defeated" % [BaseEnemy.name])
		
		$AnimationPlayer.play("enemy_died")
		yield($AnimationPlayer, "animation_finished")
		
		get_tree().quit()
		
