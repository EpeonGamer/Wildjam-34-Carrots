extends StaticBody2D

var size : int = 0
var max_size = OS.get_time().hour
onready var coll : CollisionShape2D = $CollisionShape2D
onready var growT : Timer = $Grow
onready var sprite : Sprite = $Sprite
onready var sense : Area2D = $Senser
onready var audio : AudioStreamPlayer = $Audio
onready var anim : AnimationPlayer = $AnimationPlayer
var can_grow = true

func _ready():
	add_to_group("carrots")
	coll.set_deferred("disabled", false)
	growT.wait_time = (OS.get_time().minute / 2)
	growT.start()


func _on_Grow_timeout():
	if can_grow:
		for i in sense.get_overlapping_bodies():
			if i.is_in_group("carrots") and i != self:
				can_grow == false
				audio.stream = Glob.neg
				audio.play()
				anim.play("finish")
				growT.stop()
				return
			else:
				continue
		growT.wait_time = Glob.growTime
		if size >= max_size:
			audio.stream = Glob.neg
			audio.play()
			anim.play("finish")
			growT.stop()
			return
		var amount = coll.shape.radius / 2
		size += 1
		scale += Vector2(1,1)
		var pos = position
		position = Vector2(pos.x, pos.y - amount)
		Glob.update_carrot_size(2 * size)
