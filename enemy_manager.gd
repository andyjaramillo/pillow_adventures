extends Node

var enemies_killed : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_enemy_killed():
	enemies_killed += 1

func get_enemies_killed():
	return enemies_killed