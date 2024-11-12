extends Node2D


 
var lines : Array[LineTuple]
var draw_polygon_ : bool = false
var polygon_array : PackedVector2Array
@export var polygon_texture : Texture2D
# Called when the node  enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.set_player($Player)
	EnemyManager.set_audio($EnemyManager/AudioStreamPlayer2D)
	$AudioStreamPlayer2D.play() 
 	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	if !draw_polygon_: 
		if lines.size() > 2:
			for line in lines:
				draw_line(line.previous_marker_position, line.current_marker_position, Color(0,0,1))	
	else:
		var polygon_uvs : PackedVector2Array
		for i in polygon_array.size(): 
			polygon_uvs.append(Vector2(0,0)) 
 
		if is_valid_polygon(lines):
			draw_polygon(polygon_array, [Color("478cbf")], polygon_uvs, polygon_texture)
		else:

			polygon_array.clear()
			$Player.attack_position_vector.clear()
			lines.clear()
	#	draw_polygon_ = false
	
func line_tuple_array_to_vector2_array(line_tuple_array : Array[LineTuple]):
	var vector2_array : Array[Vector2]
	for line in line_tuple_array:
		vector2_array.append(line.previous_marker_position)
	vector2_array.append(line_tuple_array.back().current_marker_position)
	return vector2_array
	
func is_valid_polygon(polygon_points : Array[LineTuple]):
	## Algorithm
		# Loop through every set of lines
		# for every grouping of two lines, see if they intersect
		# we can cache previosly done intersecting lines, we do this by storing
		# the index and then checking if we have checked for both indexs before
	var visited_lines : PackedVector2Array ## We use a packed2dvector to store 
	## two lines. they arent actually vectors in a 2d cartesian plane
	for line_i in polygon_points.size():
		for interesecting_line_i in polygon_points.size():
			if line_i == interesecting_line_i or polygon_points[line_i].share_points(polygon_points[line_i], polygon_points[interesecting_line_i]):
				continue
			else:
				var intersect = Geometry2D.segment_intersects_segment(polygon_points[line_i].previous_marker_position, polygon_points[line_i].current_marker_position, polygon_points[interesecting_line_i].previous_marker_position, polygon_points[interesecting_line_i].current_marker_position)
			
				if intersect != null:
					print(line_i, interesecting_line_i)
					return false 
	return true
 
func _on_player_trigger_draw(prev: Variant, current: Variant) -> void:
	var current_line_tuple = LineTuple.new()
	current_line_tuple.previous_marker_position = prev 
	current_line_tuple.current_marker_position = current
	lines.append(current_line_tuple)
	queue_redraw()
	pass # Replace with function body.


func _on_player_trigger_polygon_draw() -> void:
	polygon_array = line_tuple_array_to_vector2_array(lines)
	draw_polygon_ = true
	queue_redraw()
	pass # Replace with function body.
 

func _on_player_delete_polygon() -> void:
	polygon_array.clear()
	lines.clear()
	draw_polygon_ = false
	queue_redraw()


func _on_player_trigger_hit(lives_remaining: Variant) -> void:
	$Hud.delete_hearts(lives_remaining)
	if lives_remaining == 0:
		SceneManager.switch_scene("EndScreen")
	pass # Replace with function body.
