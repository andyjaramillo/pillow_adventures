extends PointLight2D
class_name Cloud

var direction : int = 1
@export var MOVING_SPEED : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func create_cloud(scene, direction):
	var new_cloud = scene.instantiate()
	new_cloud.direction = direction
	return new_cloud

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x > 1152:
		queue_free()	
	position.x += MOVING_SPEED * delta * direction
	pass
