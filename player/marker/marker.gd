extends Marker2D
class_name Marker
signal overlap(overlapped, current ,state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		overlap.emit(position, body.position, true)
		$Sprite2D.material.set_shader_parameter("intensity", 0.75)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		overlap.emit(position, body.position, false)
		$Sprite2D.material.set_shader_parameter("intensity", 0.0)
