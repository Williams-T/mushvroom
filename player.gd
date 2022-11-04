extends KinematicBody2D

onready var label = $Camera2D/Label

var wheel_base = 15 # based on sprite size
var steering_angle = 10
var torque = 400

var acceleration = Vector2.ZERO
var friction = -0.8
var drag = 0.0015

var braking = -350
var max_speed_reverse = 400

var slip_speed = 250
var traction_fast = 0.1
var traction_slow = 0.5

var velocity = Vector2.ZERO
var steer_angle

var debug_mode = true
var debug_line = []

func debug_text():
	var debug_s = "Velocity: %s \nSteer Angle: %s"
	var debug_string = debug_s % [velocity, steer_angle]
	label.text = debug_string
	pass

func get_input():
	var turn = 0
	if Input.is_action_pressed("left"):
		turn -= 1
		pass
	if Input.is_action_pressed("right"):
		turn += 1
		pass
	steer_angle = turn * deg2rad(steering_angle)
	if Input.is_action_pressed("gas"):
#		velocity = transform.x * 500
		acceleration = transform.x * torque
		pass
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
		pass
	if Input.is_action_pressed("e_brake"):
		pass
	if Input.is_action_just_released("e_brake"):
		pass

func steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity*delta
	front_wheel += velocity.rotated(steer_angle) * delta
	var new_heading = ( front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
		
	pass

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	debug_text()
	pass
