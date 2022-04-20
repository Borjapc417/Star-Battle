extends Control

signal boton_presionado
signal nueva_partida


func _on_Nueva_Partida_pressed():
	emit_signal("nueva_partida")


func _on_Button_pressed():
	emit_signal("boton_presionado")
	
func _ready():
	iniciar_percent_visible()
	
func _process(delta):
	if $Label.percent_visible!=1:
		$Label.percent_visible=1-($StartLetrasTimer.time_left/$StartLetrasTimer.wait_time)


func iniciar_percent_visible():	
	$Label.percent_visible=0.0
	$StartLetrasTimer.start()
