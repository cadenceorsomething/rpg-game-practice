extends Node2D

var button_type = null



func _on_start_pressed():
	SceneTransition.change_scene("res://src/world/world2.tscn")


func _on_load_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_quit_pressed():
	get_tree().quit()



func _on_credits_and_message_pressed():
	get_tree().change_scene_to_file("res://CREDITMSG.tscn")


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("")
