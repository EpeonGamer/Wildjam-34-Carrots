extends KinematicBody2D

var move_speed : int = 100
var friction : int = 10
var accel : int = 10
var cur_carrots : int = 0
var action : bool = true
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
export var offset : Vector2 =  Vector2(0,10)

onready var carrot : PackedScene = preload("res://Scenes/Carrot.tscn")
onready var cChecker : Area2D = $Area2D
onready var audio : AudioStreamPlayer = $AudioStreamPlayer2D
onready var indicator : ColorRect = $CanPlant
onready var anim : AnimationPlayer = $AnimationPlayer
var color : String = "g"


func _input(event):
	if Input.is_action_just_pressed("plant") and action:
		if check_carrot() != false:
			action = false
			#animation
			var cur_carrot = carrot.instance()
			cur_carrot.global_position = global_position + offset
			yield(get_tree().create_timer(1), "timeout")
			get_parent().add_child(cur_carrot)
			action = true

func _physics_process(delta):
	direction = Vector2.ZERO
	if action:
		
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction = direction.normalized()
	
	if direction.length() > 0:
		velocity = lerp(velocity, direction * move_speed, accel * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide_with_snap(velocity, Vector2.ZERO)
	
	if check_carrot() and color != "g":
		indicator.color = Color(0,1,0,1)
		color = "g"
		anim.play("yes")
	elif check_carrot() == false and color != "r":
		indicator.color = Color(1,0,0,1)
		color = "r"
		anim.play("no")


func check_carrot():
	for i in cChecker.get_overlapping_bodies():
		if i.is_in_group("carrots"):
			return false
			#break
		else:
			continue
	return true

