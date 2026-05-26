class_name Player
extends CharacterBody2D

const D_BUG_JUMP_INDICATOR = preload("uid://cxynln4h88jwb")

#region /// on ready variables
@onready var character: Sprite2D = $Character
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_raycast: RayCast2D = $OneWayPlatformRaycast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region /// Export variables
@export var move_speed : float = 100
@export var	max_fall_speed : float = 600
#endregion


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
var gravity_multiplier : float = 1.0
#endregion



func _ready() -> void:
	initialize_states()
	pass
	


func _unhandled_input( event: InputEvent ) -> void:
	change_state( current_state.handle_inputs( event ) )
	pass



func _process( _delta: float ) -> void:
	update_direction()
	change_state( current_state.process( _delta ) )
	pass

func _physics_process( _delta: float ) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	velocity.y = clampf( velocity.y, -1000.0, max_fall_speed )
	move_and_slide()
	change_state( current_state.physics_process( _delta ) )
	pass


	
func initialize_states() -> void:
	states = []
	# gather all states
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
		
	if states.size() == 0:
		return

	# initialize all states
	for state in states:
		state.init()
		
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	# set our first state
	
	pass
	
	
	
func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
	
	states.push_front( new_state )
	current_state.enter()
	states.resize( 3 )
	$Label.text = current_state.name
	pass
	
	
	
func update_direction() -> void:
	var prev_direction : Vector2 = direction
	var x_axis = Input.get_axis("move_left", "move_right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	if prev_direction.x != direction.x:
		if direction.x < 0:
			character.flip_h = true
		elif direction.x > 0:
			character.flip_h = false
	pass
	
	
func add_debug_indicator( color : Color = Color.RED ) -> void:
	var d : Node2D = D_BUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d.queue_free()
	
	
	
	
	
	
	
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
	
