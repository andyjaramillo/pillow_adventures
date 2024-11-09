extends Node

var player: Player


func set_player(player_scene):
	player = player_scene

func get_player_position():
	return player.global_position

func get_player_lives():
	return player.lives
