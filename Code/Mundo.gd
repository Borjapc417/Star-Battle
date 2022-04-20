extends Node2D

export (PackedScene) var asteroid

var asteroidesON
var countScore
var score=0


export (int) var knocbackSpeedUP = 15
export (int) var knocbackSpeedDOWN = 0.001
var knocback = Vector2.ZERO

func _process(delta):
	$Llave.look_at(get_global_mouse_position())
	$Llave.rotate(PI/2)
	$ScoreLabel.text=str(score)
	$Llave.position+=knocback
	knocback = knocback * knocbackSpeedDOWN
	if asteroidesON==true &&Input.is_action_just_pressed("left_click"):
		knocback = -Vector2(get_global_mouse_position().x-$Llave.position.x, get_global_mouse_position().y-$Llave.position.y).normalized() *knocbackSpeedUP
		$LaserAudio.play()
		$Proyectil.show()
		$Proyectil.position=Vector2($Llave.position.x, $Llave.position.y)
		$Proyectil.look_at(get_global_mouse_position())
		$Proyectil.rotate(PI/2)
	

func _ready():
	var vwrp=get_viewport_rect().size
	$Llave.position=Vector2(vwrp.x/2, vwrp.y/2)
	$Control.iniciar_percent_visible()
	$Control/NuevaPartida.hide()
	$Control/NuevaPartidaLabel.hide()
	$Control/Label.text="BIENVENIDO A STAR BATTLE"
	$Llave.hide()
	$Proyectil.hide()
	$ScoreLabel.hide()


func _on_Proyectil_fuera():
	$Proyectil.position=Vector2($Llave.position.x, $Llave.position.y)
	$Proyectil.hide()
	

func _on_Control_boton_presionado():
	$TimerStart.start()
	


func _on_Timer_timeout():
	if asteroidesON==true:
		randomize()
		var vwprt=get_viewport_rect().size
		var positionNew=Vector2.ZERO
		var hOv=randi()%2
		var minOmax=randi()%2
		if hOv==0:
			positionNew.x=randf()*vwprt.x
			if minOmax==0:
				positionNew.y=0
			else:
				positionNew.y=vwprt.y
				
		else:
			positionNew.y=randf()*vwprt.y
			if minOmax==0:
				positionNew.x=0
			else:
				positionNew.x=vwprt.x
			
		var a=asteroid.instance()
		a.connect("asteroidDead", self, "mas_score")
		a.connect("playerDead", self, "muerto")
		add_child(a)
		if(score>21):
			a.speed = 300
		a.hide()
		a.position=positionNew
		a.ready()
		a.show()
		$TimerAsteroid.start()
		print("Posicion Path: ", a.position)

#Dificultad
func _on_Score_timeout():
	if countScore==true:
		score+=1
		if score>5 && score<81:
			$TimerAsteroid.wait_time= float(1-(0.05*(score/5)))
		$Score.start()

func _on_TimerStart_timeout():
	asteroidesON=true
	countScore=true
	$Control.hide()
	$ScoreLabel.show()
	$Llave.show()
	$Proyectil.show()
	var vwrp=get_viewport_rect().size
	$Llave.position=Vector2(vwrp.x/2, vwrp.y/2)
	$TimerAsteroid.start()
	$Score.start()


func _on_Control_nueva_partida():
	get_tree().reload_current_scene()
	
func mas_score():
	$RockDestruction.play()
	score+=1
#Player dead
func _on_Llave_area_entered(area):
	$Llave.hide()
	$Proyectil.hide()
	asteroidesON=false
	countScore=false
	$Control/Label.text="!HAS PERDIDO!"
	$Control.iniciar_percent_visible()
	$Control.show()
	$Control/Button.hide()
	$Control/JugarLabel.hide()
	$Control/NuevaPartida.show()
	$Control/NuevaPartidaLabel.show()
	print("MUERTO!!")
