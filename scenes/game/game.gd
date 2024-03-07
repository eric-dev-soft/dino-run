extends Node2D

@onready var player = $Player
@onready var ground = $Ground
@onready var camera_2d = $Camera2D
@onready var barrier = $Barrier
@onready var barrier_2 = $Barrier2

const PLAYER_START_POS := Vector2i(150,485)

var screen_size: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	_on_new_game()

func _process(delta):
	GameManager.speed = GameManager.START_SPEED
	player.position.x += GameManager.speed
	camera_2d.position.x  += GameManager.speed
	barrier.position.x  += GameManager.speed
	barrier_2.position.x  += GameManager.speed
	ScoreManager.increment_score()
	
	if camera_2d.position.x - ground.position.x > screen_size.x * 1:
		ground.position.x += screen_size.x

func _on_new_game():
	SignalManager.on_game.emit()
	ScoreManager.set_score(0)
	player.position = PLAYER_START_POS
	player.velocity = Vector2i(0, 0)
	camera_2d.position = Vector2i(0, 0)
	ground.position = Vector2i(0, 0)

func _on_wait():
	pass
