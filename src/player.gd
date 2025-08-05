extends CharacterBody2D

@export var speed = 0
@export var base_speed = 100
@export var max_speed = 250
@export var acceleration = 200
@export var deceleration = 250

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var screen_size
var last_dir := Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	anim.scale = Vector2(1,1)

func _process(delta: float) -> void:
	
	$Label.text = str(int(speed))
	var dir = get_input()
	check_sprint(delta, dir)
	move(delta, dir)

func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x,y).normalized()

func check_sprint(delta:float, dir:Vector2):
	if Input.is_action_pressed("sprint") and dir.length() != 0:
		speed = min(speed + acceleration * delta, max_speed)
	else:
		speed = max(speed - deceleration * delta, base_speed)
	
	var speed_ratio = speed / base_speed
	
	anim.speed_scale = speed_ratio


func move(delta : float, direction : Vector2):
	# apply movement
	
	velocity = speed * direction
	position += velocity * delta
	
	#update_sprite(direction)
	if velocity.length() > 0:
		last_dir = velocity
		
		if velocity.x != 0:
			anim.animation = "run_right"
			anim.flip_h = velocity.x < 0
			anim.play()
		elif velocity.y != 0:
			anim.animation = "run_back" if velocity.y < 1 else "run_front"
			anim.play()
	else:
		if last_dir.x !=0:
			anim.animation = "idle_right"
			anim.flip_h = last_dir.x < 0
			anim.play()
		elif last_dir.y != 0:
			anim.animation = "idle_back" if last_dir.y < 1 else "idle_front"
			anim.play()
