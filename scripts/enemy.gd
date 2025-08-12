extends CharacterBody2D

var speed = 50
var player_present = false
var player : CharacterBody2D = null
var last_flip = false

func _ready() -> void:
	flip_the_right_sprites_to_make_left_ones()

func _physics_process(delta: float) -> void:
	detect_and_chase(delta)
	
	var direction = get_direction()
	orient_sprite(direction)


func detect_and_chase(delta: float):
	var close_radius = 12
	
	
	
	if player_present and position.distance_to(player.position) > close_radius:
		position += (player.position - position)/ speed


func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	player = body
	player_present = true
func _on_detection_area_body_exited(body: CharacterBody2D) -> void:
	player = null
	player_present = false
func flip_the_right_sprites_to_make_left_ones():
	var sprite: AnimatedSprite2D = $AnimatedSprite2D
	
	sprite.animation = "walk_left"
	sprite.flip_h = true
func get_direction() -> Vector2:
	if player == null:
		return Vector2(0,0)
	
	var direction = position - player.position
	if abs(direction.x) > abs(direction.y):
		return Vector2(sign(direction.x),0)
	else:
		return Vector2(0,sign(direction.y))
func orient_sprite(direction: Vector2):
	var sprite: AnimatedSprite2D = $AnimatedSprite2D
	
	if direction.length() != 0:
		if abs(direction.x) > abs(direction.y):
			sprite.animation = "walk_right"
			sprite.flip_h = true if direction.x > 0 else false
			last_flip = sprite.flip_h
		else:
			sprite.animation = "walk_up" if direction.y > 0 else "walk_down"
			
	else:
		if sprite.animation == "walk_up": sprite.animation = "idle_up"
		if sprite.animation == "walk_right": 
			sprite.animation = "idle_right"
			sprite.flip_h = last_flip
		if sprite.animation == "walk_down": sprite.animation = "idle_down"
		
	
	sprite.play()
