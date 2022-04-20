extends Area2D
var destination = Vector2()
signal asteroidDead
signal playerDead
export (float) var speed=200.0

func _physics_process(delta):
	position += destination.normalized()*speed*delta
	

func ready():
	randomize()
	var vwprt=get_viewport_rect().size
	var posX=randf()*vwprt.x
	var posY=randf()*vwprt.y
	destination=Vector2(posX, posY)
	destination = Vector2(destination.x-position.x, destination.y-position.y)
	print(destination)

func _ready():
	hide()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_asteroid_body_entered(body):
	emit_signal("asteroidDead")
	queue_free()
		
