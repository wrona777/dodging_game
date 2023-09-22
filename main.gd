extends Node

@export var mob_scene: PackedScene
var score

func game_over():
	get_node("ScoreTimer").stop()
	get_node("MobTimer").stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	get_node("Player").start(get_node("StartPosition").position)
	get_node("StartTimer").start()
	$HUD.update_score(score)	
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	get_node("MobTimer").start()
	get_node("ScoreTimer").start()



func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("MobPatch/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)
