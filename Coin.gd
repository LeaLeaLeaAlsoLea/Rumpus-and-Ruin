extends Area2D

@onready var anim= $AnimatedSprite2D
signal coin_collected

func _ready():
	anim.play("Coin_spin")

func _process(delta):
	pass


func _on_coin_body_entered(body):
	#queue_free()
	$AnimationPlayer.play("coin_bounce")
	emit_signal("coin_collected")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
