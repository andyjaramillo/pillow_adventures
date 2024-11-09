extends Area2D
class_name Player

@export var SPEED : int
@export var lives: int
@export var marker_scene : PackedScene
var attack_position_vector : Array[Vector2]
var previous_marker_position : Vector2 = Vector2(0,0)
var current_marker_position : Vector2 = Vector2(0,0)
var is_overlapping : bool = false
signal trigger_draw(prev, current)
signal trigger_polygon_draw
signal delete_polygon
signal trigger_hit(lives_remaining)
var counter : float = 0.005

# Called when the node enterMarker2D.new()s the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Hitstun.is_stopped() == false:
		var value = pulse()
		$Sprite2D.material.set_shader_parameter("time", value)
	
	if Input.is_action_pressed("up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("down"):
		position.y += SPEED * delta
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	
	if Input.is_action_just_pressed("mark") and $PolygonTimer.is_stopped():
		set_point()
 

func set_point():
	var point_marker : Marker = marker_scene.instantiate()
	point_marker.position = position
	point_marker.overlap.connect(check_grouping)
	if attack_position_vector.size() > 0:
		current_marker_position = point_marker.position
		previous_marker_position = attack_position_vector.back()
		if is_overlapping and attack_position_vector.size() > 3:
			trigger_polygon_draw.emit()
			$PolygonTimer.start()
		else:
			trigger_draw.emit(previous_marker_position, current_marker_position)

	attack_position_vector.append(point_marker.position)

	get_tree().current_scene.add_child(point_marker)
	
func check_grouping(prev, current, state):
	is_overlapping = state
 	
func pulse():
	counter += 0.005
	return sin(2 * PI * counter) + 1

func _on_polygon_timer_timeout() -> void:
	delete_polygon.emit()
	$PolygonTimer.stop()
	get_tree().call_group("marker", "queue_free")
	get_tree().call_group("enemy", "clear_if_inside", attack_position_vector)
	attack_position_vector.clear()




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and $Hitstun.is_stopped():
		lives -= 1
		trigger_hit.emit(lives)
		$Hitstun.start()
		$Sprite2D.material.set_shader_parameter("is_on", 1)
		
 


func _on_hitstun_timeout() -> void:
	$Hitstun.stop()
	$Sprite2D.material.set_shader_parameter("is_on", 0)
 
