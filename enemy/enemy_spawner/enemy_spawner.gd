extends Node2D

@export var enemy_scene: PackedScene

@export var spawn_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Sprite2D.visible = true
	#await get_tree().create_timer(2).timeout
	#$Sprite2D.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_enemy_spawner_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	$EnemySpawner.start()
	


func get_top_left():
	## returns the top right of the rectangle
	return Vector2(global_position.x-(spawn_size.x/2), global_position.y - (spawn_size.y/2) )
	
func get_bottom_right():
	return Vector2(global_position.x + (spawn_size.x/2), global_position.y + (spawn_size.y/2) )
