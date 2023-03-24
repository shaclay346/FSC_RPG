extends KinematicBody2D
var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var house = null setget set_house


func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interact") and house != null:
		Global.player_pos = global_position
		house.enter()
func _ready():
	set_house(null)

func set_house(new_house):
	if new_house != null:
		$Key.show()
	else:
		$Key.hide()
	house = new_house
	
func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		direction = Vector2(0,1)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		direction = Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		direction = Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		direction = Vector2(1,0)	
	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 200)
	
func _physics_process(delta):
	read_input()
