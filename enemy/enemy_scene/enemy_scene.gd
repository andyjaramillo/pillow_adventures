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
	print(Geometry2D.is_point_in_polygon(global_position, polygon_vector), self.global_position)
	if Geometry2D.is_point_in_polygon(global_position, polygon_vector):
		EnemyManager.add_enemy_killed()
		queue_free()
	
