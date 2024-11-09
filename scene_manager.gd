extends Node


@export var scenes: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes["StartScreen"] = "res://start_screen/start_screen.tscn"
	scenes["MainScene"] = "res://main_scene/main_area.tscn"
	scenes["EndScreen"] = "res://end_screen/end_screen.tscn"
	pass # Replace with function body.



# Switch to the requested scene based on its alias
func switch_scene(scene_alias : String) -> void:
	get_tree().change_scene_to_file.bind(scenes.get(scene_alias)).call_deferred()
