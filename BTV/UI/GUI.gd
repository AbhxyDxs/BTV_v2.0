extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

var pause_menu = load("res://PauseMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Player_Data.Health:
		var New_Heart = Sprite2D.new()
		New_Heart.texture = $Heart.texture
		New_Heart.hframes = $Heart.hframes
		$Heart.add_child(New_Heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$"CoinCount Label".text = var_to_str(Player_Data.Coin)
	
	for heart in $Heart.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x,y)
		
		var Last_Heart = floor(Player_Data.Health)
		
		if index > Last_Heart:
			heart.frame = 0
		if index == Last_Heart:
			heart.frame = (Player_Data.Health - Last_Heart) * 4
		if index < Last_Heart:
			heart.frame = 4



