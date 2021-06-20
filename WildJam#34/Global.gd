extends Node

var carrots : int = 0
var carrot_size_total : int = 0
var growTime : float = 1
var fullscreen : bool = false

var neg : = preload("res://Import/GUI_Sound_Effects_by_Lokif/negative_2.wav")

func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())

func _physics_process(delta):
	growTime = (OS.get_time().minute / 2)
	carrots = get_tree().get_nodes_in_group("carrot").size()

func update_carrot_size(amount):
	carrot_size_total += amount

func _input(event):
	if Input.is_action_just_pressed("fullscreen"):
		if not fullscreen:
			fullscreen = true
			OS.set_window_fullscreen(true)
		else:
			fullscreen = false
			OS.set_window_fullscreen(false)
