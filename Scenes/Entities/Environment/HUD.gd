extends CanvasLayer

var coins = 0

func _ready():
	$"coin numb".text = str(coins)



func _process(delta):
	pass


func _on_coin_collected():
	coins += 1
	_ready()
