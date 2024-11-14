extends Control

var counter = 1
var is_valid 	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_valid:
		$TextureRect.material.set_shader_parameter("time", pulse())
	 
	

func pulse():
	counter -= 0.005
	return sin(2 * PI * counter) 

func _on_button_pressed() -> void:
	$StartupSound.play()
	$TextureRect.material.set_shader_parameter("is_on", 1)
 
	create_tween().tween_property($StartButton, "modulate", Color.TRANSPARENT, 2)
	is_valid = true
	await $StartupSound.finished
	SceneManager.switch_scene("MainScene")
	pass # Replace with function body.
	
func _on_options_button_pressed() -> void:
	pass # Replace with function body.
