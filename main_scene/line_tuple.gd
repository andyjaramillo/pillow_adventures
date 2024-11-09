class_name LineTuple

var previous_marker_position : Vector2 = Vector2(0,0)
var current_marker_position : Vector2 = Vector2(0,0)
 
func share_points(first: LineTuple, second: LineTuple):
	if first.previous_marker_position == second.previous_marker_position or first.current_marker_position == second.previous_marker_position or first.previous_marker_position == second.current_marker_position:
		return true
	else:
		return false
