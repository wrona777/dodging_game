extends Area2D
signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 150
	if Input.is_action_pressed("move_left"):
		velocity.x -= 150
	if Input.is_action_pressed("move_down"):
		velocity.y += 150
	if Input.is_action_pressed("move_up"):
		velocity.y -= 150
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		get_node("AnimatedSprite2D").animation = "walk"
		get_node("AnimatedSprite2D").flip_v = false
		get_node("AnimatedSprite2D").flip_h = velocity.x < 0
	elif velocity.y != 0:
		get_node("AnimatedSprite2D").animation = "up"
		get_node("AnimatedSprite2D").flip_v = velocity.y > 0
				
#	if velocity.x < 0:
#		$AnimatedSprite2D.flip_h = true
#	else:
#		$AnimatedSprite2D.flip_h = false
		

		
		


func _on_body_entered(body):
	hide()
	hit.emit()
	get_node("CollisionShape2D").set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	get_node("CollisionShape2D").disabled = false
