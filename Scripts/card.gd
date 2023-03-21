extends Node3D

const MOUSE_OVER_Y_DISLOCATION = .5

var is_mouse_over : bool = false


func _card_mouse_entered():
	#global_position.y += MOUSE_OVER_Y_DISLOCATION
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($card_placeholder, "position", Vector3(0.0, MOUSE_OVER_Y_DISLOCATION, 0.0), 0.01)
	is_mouse_over = true
	print("Mouse enter")


func _card_mouse_exited():
	#global_position.y -= MOUSE_OVER_Y_DISLOCATION
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($card_placeholder, "position",  Vector3(0.0, 0.0, 0.0), 0.01)
	is_mouse_over = false
	print("Mouse exit")
