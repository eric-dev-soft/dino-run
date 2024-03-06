extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#SignalManager.on_player_idle.connect(_on_idle)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_idle():
	#animated_sprite_2d.play("idle")
	pass
