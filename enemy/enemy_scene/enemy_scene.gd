extends Node2D

@onready var anim_player: AnimationPlayer = $Sprite2D/AnimationPlayer



@export var tracking_speed : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.lerp(PlayerManager.get_player_position(), tracking_speed)
	 
	

func clear_if_inside(polygon_vector: PackedVector2Array):
	var square_polygon : PackedVector2Array = [Vector2(global_position.x - 14, global_position.y -14), Vector2(global_position.x + 14, global_position.y -14), Vector2(global_position.x-14, global_position.y + 14), Vector2(global_position.x + 14, global_position.y + 14)]
	print(Geometry2D.intersect_polygons(square_polygon, polygon_vector).size(), self.global_position)
	if Geometry2D.intersect_polygons(square_polygon, polygon_vector).size() > 0:
		EnemyManager.kill_dream()
		EnemyManager.add_enemy_killed()
		queue_free()
	
