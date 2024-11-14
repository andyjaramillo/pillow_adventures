extends Node2D

@export var enemy_scene: PackedScene

signal enemy_manager_update

@export var spawn_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_signal():
	return enemy_manager_update


func _on_enemy_spawner_timeout() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.get_signal().connect(trigger_enemy_manager_update)
	add_child(enemy)
	$EnemySpawner.start()
	
func trigger_enemy_manager_update():
	enemy_manager_update.emit()
	
func clear_if_inside(polygon_vector: PackedVector2Array):
	var square_polygon : PackedVector2Array = [Vector2(global_position.x - 25, global_position.y -25), Vector2(global_position.x + 25, global_position.y -25), Vector2(global_position.x-25, global_position.y + 25), Vector2(global_position.x + 25, global_position.y + 25)]
	if Geometry2D.intersect_polygons(square_polygon, polygon_vector).size() > 0:
		EnemyManager.kill_dream()
		EnemyManager.add_enemy_killed()
		queue_free()
	
	


func get_top_left():
	## returns the top right of the rectangle
	return Vector2(global_position.x-(spawn_size.x/2), global_position.y - (spawn_size.y/2) )
	
func get_bottom_right():
	return Vector2(global_position.x + (spawn_size.x/2), global_position.y + (spawn_size.y/2) )


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.trigger_die()
	pass # Replace with function body.
