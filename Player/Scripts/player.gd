class_name Player
extends CharacterBody2D

#region /// State Machine Variables
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
#endregion


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _process( _delta: float ) -> void:
	
	pass

func _physics_process( _delta: float ) -> void:
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
