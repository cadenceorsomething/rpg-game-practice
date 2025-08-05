extends CharacterBody2D

@export var speed = 400
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var screen_size
var last_dir := Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	anim.scale = Vector2(3,3)

func _process(delta: float) -> void:
	
	var dir = get_input()
	move(delta, dir)

func get_input() -> Vector2:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x,y).normalized()


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
