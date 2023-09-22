extends RigidBody2D


func _ready():
	var mob_types = get_node("AnimatedSprite2D").sprite_frames.get_animation_names()
	get_node("AnimatedSprite2D").play(mob_types[randi() % mob_types.size()])
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
