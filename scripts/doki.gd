extends CharacterBody2D

var speed = 75
var base_speed = 75
var max_speed = 200
var acceleration = 200
var deceleration = 150


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cam: Camera2D = $Camera2D
	
	cam.make_current()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_direction()
	var can_sprint = check_sprint()
	
	move(direction)
	sprint(can_sprint, delta, direction)
	orient_sprite(direction)

func check_sprint() -> bool:
	return Input.is_action_pressed("sprint")


func sprint(can_sprint:bool, delta:float, direction:Vector2):
	if direction.length() != 0 and can_sprint:
		speed = min(speed + acceleration * delta, max_speed)
	else:
		speed = max(speed - deceleration * delta, base_speed)
	
	var sprite: AnimatedSprite2D = $AnimatedSprite2D
	var speed_ratio = speed / base_speed
	
	sprite.speed_scale = speed_ratio

func get_direction() -> Vector2:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
	elif Input.is_action_pressed("left"):
		direction.x -= 1
	
	if Input.is_action_pressed("down"):
		direction.y += 1
	elif Input.is_action_pressed("up"):
		direction.y -= 1
	
	
	return direction.normalized()

func move(direction:Vector2):
	velocity = speed * direction
	move_and_slide()
	
func orient_sprite(direction:Vector2):
	var sprite : AnimatedSprite2D = $AnimatedSprite2D
	
	if direction.length() != 0:
		if direction.x != 0:
			sprite.animation = "walk_right" if direction.x > 0  else "walk_left"
		else:
			sprite.animation = "walk_up" if direction.y < 0  else "walk_down" 
		sprite.play()
	else:
		sprite.frame = 1
		sprite.pause()
