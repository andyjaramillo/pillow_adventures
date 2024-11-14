extends CanvasLayer

@export var heart: Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.add_image(heart)
	$RichTextLabel.add_image(heart)
	$RichTextLabel.add_image(heart)
	 
	pass # Replace with function body.

func update_enemy_killed(killed):
	$Label.text = str(killed) + "Killed"


func delete_hearts(hearts_remaining):
 
	$RichTextLabel.clear()
	for hearts in hearts_remaining:
		$RichTextLabel.add_image(heart)
