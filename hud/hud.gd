extends Control

@onready var score_label = $MarginContainer/Score
@onready var high_score_value = $MarginContainer2/HBoxContainer/HighScoreValue
@onready var press_to_play = $CenterContainer/PressToPlay

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_update_score.connect(_on_update_score)
	SignalManager.on_game.connect(_on_enter_game)
	SignalManager.on_wait.connect(_on_wait_game)

func _on_enter_game():
	press_to_play.hide()

func _on_wait_game():
	high_score_value.text = str(ScoreManager.get_high_score())
	press_to_play.show()

func _on_update_score():
	score_label.text = str(ScoreManager.get_score())
