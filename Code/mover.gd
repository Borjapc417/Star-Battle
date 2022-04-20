extends Area2D

export (int) var speed = 200

var destination = Vector2()
var velocity = Vector2()



func _ready():
	destination=position
	
func _process(delta):
	
	var vwprt=get_viewport_rect().size
	var movimiento=Vector2()
		
	if Input.is_action_pressed("ui_up"):
		movimiento.y-=1
	if Input.is_action_pressed("ui_down"):
		movimiento.y+=1
	if Input.is_action_pressed("ui_left"):
		movimiento.x-=1
	if Input.is_action_pressed("ui_right"):
		movimiento.x+=1
	movimiento=movimiento.normalized() * speed * delta
	position+=movimiento
	
	position.x = clamp(position.x, 0, vwprt.x)
	position.y = clamp(position.y, 0, vwprt.y)

