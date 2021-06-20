extends Node2D

onready var score = $CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/Score
onready var speed = $CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/Speed
onready var score_title = $CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/SpTitle
onready var speed_title = $CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/ScTitle
onready var anim = $AnimationPlayer

onready var last_score : String = "[center]" + String(Glob.carrots + Glob.carrot_size_total) + "[/center]"
var new_score : String

func _physics_process(delta):
	var new_score : String = "[center]" + String(Glob.carrots + Glob.carrot_size_total) + "[/center]"
	
	if new_score != last_score:
		last_score = new_score
		upd()
	
	speed.bbcode_text = "[center]" + String(OS.get_time().minute) + " MIN / 2 = " + String(Glob.growTime) + "[/center]"

func upd():
	score.bbcode_text = "[center]" + String(Glob.carrots + Glob.carrot_size_total) + "[/center]"
	anim.play("click")


func _on_Button_pressed():
	get_tree().reload_current_scene()
