extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EnemiesDestroyed.text = "Enemies Killed: " + str(EnemyManager.get_enemies_killed())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	SceneManager.switch_scene("StartScreen")
	pass # Replace with function body.
