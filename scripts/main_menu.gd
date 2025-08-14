extends Node2D


func _on_start_pressed():
	get_tree().change_scene_to_file("res://src/world/world.tscn")


func _on_load_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_quit_pressed():
	get_tree().quit()



func _on_credits_and_message_pressed():
	get_tree().change_scene_to_file("res://CREDITMSG.tscn")
