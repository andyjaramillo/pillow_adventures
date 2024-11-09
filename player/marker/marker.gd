extends Marker2D
class_name Marker
signal overlap(overlapped, current ,state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		overlap.emit(position, area.position, true)
		$Sprite2D.material.set_shader_parameter("intensity", 0.75)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		overlap.emit(position, area.position, false)
		$Sprite2D.material.set_shader_parameter("intensity", 0.0)
