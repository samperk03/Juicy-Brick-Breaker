extends StaticBody2D
var decay = 0.01


func _on_left_sensor_body_entered(_body):
	pass # Replace with function body.


func _on_top_sensor_body_entered(_body):
	if $ColorRect.color.s > 0:
		$ColorRect.color.s -= decay 
	if $ColorRect.color.v < 1:
		$ColorRect.color.v += decay 
		


func _on_right_sensor_body_entered(_body):
	pass
	
func hit():
	$ColorRect.color = Color8(201,80,45,255)
	
