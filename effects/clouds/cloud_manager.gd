extends CollisionShape2D

 

@export var cloud_instance : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 
	pass # Replace with function body.


 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_cloud : Cloud = cloud_instance.instantiate()
	new_cloud.direction = 1
	var random_x = randi_range(global_position.x - (shape.get_rect().size.x / 2) , global_position.x + (shape.get_rect().size.x / 2))
	var random_y = randi_range(global_position.y - (shape.get_rect().size.y / 2) , global_position.y + (shape.get_rect().size.y / 2))
	new_cloud.global_position = Vector2(random_x, random_y)
	get_tree().current_scene.add_child(new_cloud)
	$Timer.start()
