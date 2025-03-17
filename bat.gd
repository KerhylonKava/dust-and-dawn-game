extends CharacterBody2D

@export var speed := 800  # How fast the bat charges
@export var attack_delay := 1  # Seconds between attacks
@export var knockback_strength := 5000  # Knockback force
var player_in_area = false
@onready var SootSprite = get_parent().get_node("SootSprite")
var start_position: Vector2
var attacking := false

func _ready():
	start_position = global_position  # Store where the bat starts
	await get_tree().create_timer(attack_delay).timeout  # Wait before first attack
	attack()

func attack():
	attacking = true
	var direction = (SootSprite.global_position - global_position).normalized()
	velocity = direction * speed
	await get_tree().create_timer(2).timeout  # Attack duration
	
	velocity = Vector2.ZERO
	global_position = start_position  # Return to start
	attacking = false
	
	await get_tree().create_timer(attack_delay).timeout  # Wait and attack again
	attack()

func _physics_process(delta):
	if attacking:
		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		var knockback_dir = (SootSprite.global_position - global_position).normalized()
		SootSprite.velocity += knockback_dir * knockback_strength  # Push the player
		print("hath been attacked")


"""
extends CharacterBody2D

@export var speed := 800.0  # How fast the bat charges
@export var attack_delay := 1  # Seconds between attacks
@export var knockback_strength := 100  # Knockback force
var player_in_area = false
@onready var SootSprite = get_parent().get_node("SootSprite")

var start_position: Vector2
var attacking := false

func _ready(): 
	start_position = global_position  # Store where the bat starts

func attack():
	var direction = (SootSprite.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	await get_tree().create_timer(5).timeout  # Attack duration
	if player_in_area:
		var knockback_dir = (SootSprite.global_position - global_position).normalized()
		SootSprite.velocity += knockback_dir * knockback_strength  # Push the player
		print("hath been attacked")
	velocity = Vector2.ZERO

func _process(delta: float) -> void:
	await get_tree().create_timer(attack_delay).timeout  # Wait and attack again
	attack()
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body
"""
