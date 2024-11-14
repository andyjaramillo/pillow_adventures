extends CharacterBody2D
class_name Player


@onready var anim_player: AnimationPlayer = $Sprite2D/AnimationPlayer


@export var SPEED : int
@export var lives: int
@export var marker_scene : PackedScene
var attack_position_vector : Array[Vector2]
var previous_marker_position : Vector2 = Vector2(0,0)
var current_marker_position : Vector2 = Vector2(0,0)
var is_overlapping : bool = false
var screen_size
signal trigger_draw(prev, current)
signal trigger_polygon_draw
signal delete_polygon
signal trigger_hit(lives_remaining)
var counter : float = 0.005
var is_dying = false
var input_enabled = true
# Called when the node enterMarker2D.new()s the scene tree for the first time.
func _ready() -> void:
	
	screen_size= get_viewport_rect().size
	screen_size =  Vector2(screen_size.x - 15, screen_size.y - 35)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dying:
		anim_player.play("die")
	if $Hitstun.is_stopped() == false:
		var value = pulse()
		$Sprite2D.material.set_shader_parameter("time", value)
	
	if input_enabled:
		if Input.is_action_pressed("up") or Input.is_action_pressed("down"):
			if Input.is_action_pressed("up"):
				velocity.y = move_toward(velocity.y, -200, 50)
			#	position.y -= SPEED * delta
				anim_player.play("move_up")
			else:
				velocity.y = move_toward(velocity.y,  200, 50)
				anim_player.play("move_down")
		else:
			velocity.y = move_toward(velocity.y, 0, 50)
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			if Input.is_action_pressed("left"):
				velocity.x = move_toward(velocity.x,  -200, 50)
				anim_player.play("move_left")
			else:
				velocity.x = move_toward(velocity.x,  200, 50)
				anim_player.play("move_right")
		else:
			velocity.x = move_toward(velocity.x, 0, 50)
 
	
	position = position.clamp(Vector2(15,15), screen_size)
	move_and_slide()
	
	if Input.is_action_just_pressed("mark") and $PolygonTimer.is_stopped():
		set_point()
 	

func set_point():
	var point_marker : Marker = marker_scene.instantiate()
	point_marker.position = position
	point_marker.overlap.connect(check_grouping)
	$MarkerSound.play()
	if is_overlapping and attack_position_vector.size() > 3:
			trigger_polygon_draw.emit()
			$PolygonTimer.start()
			return
	if attack_position_vector.size() > 0:
		current_marker_position = point_marker.position
		previous_marker_position = attack_position_vector.back()
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
	get_tree().call_group("spawner", "clear_if_inside", attack_position_vector)
	attack_position_vector.clear()

func trigger_die():
	#$SpawnDeathSound.play()
	input_enabled = false
	velocity = Vector2.ZERO
	is_dying = true
	#get_tree().paused = true
func _on_hitstun_timeout() -> void:
	$Hitstun.stop()
	$Sprite2D.material.set_shader_parameter("is_on", 0)



func _on_area_2d_area_entered(area: Area2D) -> void:

	if area.is_in_group("enemy") and $Hitstun.is_stopped():
		lives -= 1
		$AudioStreamPlayer2D.play()
		trigger_hit.emit(lives)
		$Hitstun.start()
	
		$Sprite2D.material.set_shader_parameter("is_on", 1)

 

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		print("made it")
		trigger_hit.emit(0)
 #
