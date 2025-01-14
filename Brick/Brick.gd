extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false
var time_appear = 0.5
var time_fall = 0.8
var time_rotate = 1.0
var time_a = 0.8
var time_s = 1.2
var time_v = 1.5
var tween

var powerup_prob = 0.1

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	position.x = new_position.x
	position.y = -100
	tween = create_tween()
	tween.tween_property(self, "position",new_position, 0.5 + randf()*2).set_trans(tween.TRANS_BOUNCE)
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
	$CollisionShape2D.queue_free()
	Global.update_score(score)
	get_parent().check_level()
	$Confetti.emitting = true
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property(self,"position", Vector2(position.x,1000), time_fall).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation", -PI + randf()*2*PI, time_rotate).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($ColorRect, "color:a", 0, time_a)
	tween.tween_property($ColorRect, "color:s", 0, time_s)
	tween.tween_property($ColorRect, "color:v", 0, time_v)

	
	
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
