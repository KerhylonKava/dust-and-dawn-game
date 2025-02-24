extends CharacterBody2D
const UP_DIRECITON := Vector2.UP

@onready var is_moving = false

@export var speed := 450/0.0166
#scale.x = scale.y * direction 
@onready var FootSteps_Sound = $FootSteps_Sound
@onready var Jump_Sound = $Jump_Sound
@onready var animation = $AnimationPlayer

@export var inventory : Inventory

var jump_time = 0
var jump_strength := 700/0.0166
var max_jumps := 2
var jumps_made := 0

var is_falling := velocity.y > 0 and not is_on_floor()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("space"):
		#collect(item)
	#Movement
	if jump_time > 0:
		jump_time -= 1
	

	if Input.is_action_just_pressed("up"):
		animation.play("jump")
		Jump_Sound.play()
		if is_on_floor():
			jump_time = 15
			jumps_made = 1
		elif jumps_made < max_jumps:
			jump_time += 5
			jumps_made += 1
	
	elif jump_time <= 0: #Check if not jumping
		if Input.is_action_pressed("left"):
			#is_moving = true
			$SootSpriteImage.flip_h = true
			if is_on_floor():
				animation.play("run")
				if not FootSteps_Sound.playing and jump_time <= 0:
					FootSteps_Sound.play()
			velocity.x = -speed * delta
	

		
		elif Input.is_action_pressed("right"):
			#is_moving = true
			$SootSpriteImage.flip_h = false
			if is_on_floor():
				animation.play("run")
				if not FootSteps_Sound.playing and jump_time <= 0:
					FootSteps_Sound.play()
			velocity.x = speed * delta

		else: 
			velocity.x = 0 # Reset velocity when no keys are pressed
			if FootSteps_Sound.playing:
				FootSteps_Sound.stop()
			if velocity.x > 0:
				velocity.x -= 0.15 * velocity.x
			if velocity.x < 0:
				velocity.x -= 0.15 * velocity.x
			if velocity.x == 0 and is_on_floor():
				animation.play("idle")


	else:
		if FootSteps_Sound.playing:
			FootSteps_Sound.stop()
		velocity.x = 0
		if velocity.x > 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x < 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x == 0 and is_on_floor():
			animation.play("idle")

	
	
	if jump_time > 0:
		velocity.y = -jump_strength * delta
	
	#Gravity
	velocity.y += 30 * delta / 0.0166

	move_and_slide()
	


func collect(item):
	inventory.insert(item)

func remove(item):
	inventory.remove(item)
	
func soot_sprite():
	pass

var has_collected_light_sprite = false
