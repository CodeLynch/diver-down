extends CharacterBody2D

@export var speed = 500
@onready var sprite = $Sprite
@onready var o2_tank = $"../CanvasLayer/UI/TextureProgressBar"
@onready var debt_manager = $"../CanvasLayer/UI/DebtManager"
@onready var game_over_delay = $GameOverDelay
@onready var bg_music = $"../BGMusic"
var is_down = false;
var cleared_debt = false;

signal end_game()

func _ready() -> void:
	o2_tank.connect("diver_down", down)
	debt_manager.connect("diver_cleared_debt", clear_debt)
		
func get_input():
	if not is_down:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		if input_direction.x != 0 or input_direction.y != 0:
			sprite.animation = "swim"
			if input_direction.x != 0:
				if input_direction.x > 0:
					sprite.flip_h = false
				else:
					sprite.flip_h = true
		else:
			sprite.animation = "idle"
		velocity = input_direction.normalized() * speed

func down() -> void:
	if not is_down:
		is_down = true;
		if bg_music.playing:
			bg_music.stop()
		velocity = Vector2i.ZERO
		sprite.animation = "down"
		game_over_delay.start(3)

func get_eaten() -> void:
	velocity = Vector2i.ZERO
	is_down = true
	if bg_music.playing:
		bg_music.stop()
	await get_tree().create_timer(0.3).timeout
	sprite.animation = "splat"
	game_over_delay.start(3)
	

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()


func _on_game_over_delay_timeout() -> void:
	end_game.emit()

func clear_debt() -> void:
	cleared_debt = true
