extends CharacterBody2D


var speed = 50
var acceleration = 7

@export var player: Node2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var timer = $Timer

func _physics_process(delta):
	var dir = Vector2.ZERO
	
	dir = nav_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	
	velocity = velocity.lerp(dir * speed, acceleration * delta)
	
	move_and_slide()

func _on_timer_timeout():
	nav_agent.target_position = player.global_position
