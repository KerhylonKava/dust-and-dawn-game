class_name AgingComponent
extends Node

signal age_changed(new_age : float, last_age : float) 
signal age_threshold_reached(new_scene : Node2D)

@export var target : Node2D
@export var current_age = 0.0:
	set(value):
		if(current_age != value):
			var last_age = current_age
			current_age = value
			emit_signal("age_changed", current_age, last_age)
			
			if(current_age >= age_threshold && _threshold_reached != true):
				var new_scene : Node2D 
				
				if(next_scene != null):
					new_scene = _create_next_scene()
					
				emit_signal("age_threshold_reached", new_scene)
				_threshold_reached = true
				target.queue_free()

@export var age_threshold = 1.0
@export var next_scene : PackedScene

static var group_name = "AgingComponent"

func _ready():
	if(target == null):
		target = get_parent()
		
	add_to_group(group_name)

var _threshold_reached = false

func _create_next_scene() -> Node2D:
	var instance : Node2D = next_scene.instantiate()
	target.get_parent().add_child(instance)
	instance.global_transform = target.global_transform
	return instance
