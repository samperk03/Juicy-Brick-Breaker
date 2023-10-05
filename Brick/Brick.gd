extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(134,46,156,255)
	elif score >= 90: 
		$ColorRect.color = Color8(174,62,201,255)
	elif score >= 80:
		$ColorRect.color = Color8(204,93,232,255)
	elif score >= 70:
		$ColorRect.color = Color8(218,119,242,255)
	elif score >= 60:
		$ColorRect.color = Color8(229,153,242,255)
	elif score >= 50:
		$ColorRect.color = Color8(238,190,250,255)
	elif score >= 40:
		$ColorRect.color = Color8(243,217,250,255)
	else: 
		$ColorRect.color = Color8(248,240,252,255)
	

func _physics_process(_delta):
	if dying and not $Confetti.emitting:
		queue_free()

func hit(_ball):
	die()
	

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
	$Confetti.emitting = true 
