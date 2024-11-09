extends Node2D

@export var spawner_scene : PackedScene
@export var padding:int
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func does_overlap(l1, r1, l2, r2):
	if l1.x > r2.x or l2.x > r1.x:
		return false

	if r1.y > l2.y or r2.y > l1.y:
		return false
		
	return true
	
func generate_spawn_point():
	var viewport = get_tree().current_scene.get_viewport().get_visible_rect().size
	var spawn_X = rng.randi_range(0 + padding, viewport.x - padding)
	var spawn_Y = rng.randi_range(0 + padding, viewport.y - padding)
	var spawn_point = Vector2(spawn_X, spawn_Y)
	return spawn_point

func _on_timer_timeout() -> void:
	var spawner = spawner_scene.instantiate()

	var number_of_spawners : int = get_tree().get_nodes_in_group("spawner").size() - 1
	var spawn_point = generate_spawn_point()
	while number_of_spawners > 0:
		var current_spawn_instance = get_tree().get_nodes_in_group("spawner")[number_of_spawners]
		if does_overlap(current_spawn_instance.get_top_left(), current_spawn_instance.get_bottom_right(), Vector2(spawn_point.x - 20, spawn_point.y - 20), Vector2(spawn_point.x + 20, spawn_point.y + 20)):
			number_of_spawners = get_tree().get_nodes_in_group("spawner").size()
			spawn_point = generate_spawn_point()
			pass
		else:
			number_of_spawners -= 1
			number_of_spawners 
	
	spawner.global_position = spawn_point
	get_tree().current_scene.add_child(spawner)
	
