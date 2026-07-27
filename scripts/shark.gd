extends CharacterBody2D

@export var speed = 200
@export var chase_speed = 600
@export var patrol_distance = 1000
@export var turnaround_buffer = 5
@export var patrol_area: Area2D
@onready var sprite = $AnimatedSprite2D
@onready var diver = $"../../Diver"

@onready var bite_sfx = $ASPBite

var start_position: Vector2i

var direction = 1

# enemy states bool
var is_patrolling = true
var is_chasing = false
var is_returning = false

func _ready() -> void:
	start_position = global_position
	patrol_area.connect("player_entered", chase_player)
	patrol_area.connect("player_exit", return_to_start)

func _physics_process(delta: float) -> void:
	if is_patrolling:
		# move shark between two points
		velocity.x = direction * speed
		velocity.y = 0
		var left_point = Vector2i(start_position.x - patrol_distance, start_position.y)
		var right_point = Vector2i(start_position.x + patrol_distance, start_position.y)
		if direction == 1:
			if is_on_wall() or global_position.distance_to(right_point) <= turnaround_buffer:
				flip_char()
		elif direction == -1:
			if is_on_wall() or global_position.distance_to(left_point) <= turnaround_buffer:
				flip_char()
		move_and_slide()

	elif is_chasing:
		sprite.flip_h = false
		if diver.global_position.x < global_position.x:
			sprite.flip_v = true
		elif diver.global_position.x > global_position.x:
			sprite.flip_v = false
		look_at(diver.global_position)
		position += global_position.direction_to(diver.global_position) * chase_speed * delta
		
	elif is_returning:
		sprite.flip_h = false
		look_at(start_position)
		if start_position.x < global_position.x:
			sprite.flip_v = true
		elif start_position.x > global_position.x:
			sprite.flip_v = false
		velocity = global_position.direction_to(start_position) * speed
		move_and_slide()
		
		if is_on_wall() or global_position.distance_to(start_position) <= 2:
			rotation = 0
			direction = 1
			sprite.flip_v = false
			sprite.flip_h = false
			start_patrol()
		


func flip_char() -> void:
	direction = -direction
	sprite.flip_h = !sprite.flip_h

func chase_player() -> void:
	is_patrolling = false
	is_returning = false
	is_chasing = true

func start_patrol() -> void:
	is_returning = false
	is_chasing = false
	is_patrolling = true

func return_to_start() -> void:
	is_patrolling = false
	is_chasing = false
	is_returning = true

func _on_kill_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("diver"):
		sprite.animation = "bite"
		bite_sfx.play()
		diver.get_eaten()
		velocity = Vector2i.ZERO
		is_chasing = false
		await get_tree().create_timer(.3).timeout
		sprite.animation = "munch" 
