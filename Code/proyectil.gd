extends KinematicBody2D

export (int) var speed=200
var destination = Vector2()
var velocity = Vector2()

signal fuera

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):
		destination = Vector2(get_global_mouse_position().x-position.x, get_global_mouse_position().y-position.y)
	position += destination.normalized()*speed*delta
	
	
func _ready():
	destination = position
	pass # Replace with function body.


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	emit_signal("fuera")
