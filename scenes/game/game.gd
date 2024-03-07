extends Node2D

@onready var player = $Player
@onready var ground = $Ground
@onready var camera_2d = $Camera2D
@onready var barrier = $Barrier
@onready var barrier_2 = $Barrier2

var screen_size: Vector2i
var is_game_running: bool = false
const SCORE_MODIFIER: int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	SignalManager.on_game.connect(_on_game)
	SignalManager.on_wait.connect(_on_wait)

func _process(_delta):
	if Input.is_action_pressed("space"):
		_on_new_game()
	if is_game_running:
		GameManager.speed = GameManager.START_SPEED + (ScoreManager.get_score() / SCORE_MODIFIER)
		if GameManager.speed > GameManager.MAX_SPEED_RUN:
			GameManager.speed = GameManager.MAX_SPEED_RUN
		print(GameManager.speed)
		player.position.x += GameManager.speed
		camera_2d.position.x  += GameManager.speed
		barrier.position.x  += GameManager.speed
		barrier_2.position.x  += GameManager.speed
		ScoreManager.increment_score()
	
		if camera_2d.position.x - ground.position.x > screen_size.x * 1:
			ground.position.x += screen_size.x
	else:
		SignalManager.on_wait.emit()

func _on_new_game():
	SignalManager.on_game.emit()
	ScoreManager.set_score(0)
	player.position = GameManager.PLAYER_START_POS
	player.velocity = GameManager.INIT_GAME_POS
	camera_2d.position = GameManager.INIT_GAME_POS
	ground.position = GameManager.INIT_GAME_POS

func _on_game():
	is_game_running = true

func _on_wait():
	pass
