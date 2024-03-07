extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_sfx = $JumpSFX
@onready var run_sfx = $RunSFX
@onready var run_col = $RunCol

func _ready():
	SignalManager.on_game.connect(_on_game)

func _physics_process(delta):
	velocity.y += GameManager.GRAVITY * delta
	_on_action(delta)
	_change_col()
	move_and_slide()

func _on_action(delta):
	if (is_on_floor()):
		if Input.is_action_pressed("run") || Input.is_action_pressed("backward"):
			_on_move(delta)
		elif Input.is_action_pressed("jump"):
			_on_jump()
		elif Input.is_action_pressed("duck"):
			_on_duck()
		else:
			_on_idle(delta)
	else:
		animated_sprite_2d.play("jump")

func _on_idle(delta):
	animated_sprite_2d.play("idle")
	velocity.x = delta

func _on_move(delta):
	if is_on_floor():
		if Input.is_action_pressed("run"):
			if (Input.is_action_pressed("duck")):
				_on_duck()
			elif Input.is_action_pressed("jump"):
				_on_jump()
			else:
				_on_run()
			velocity.x += GameManager.SPEED_RUN * delta
		if Input.is_action_pressed("backward"):
			if (Input.is_action_pressed("duck")):
				_on_duck()
			elif Input.is_action_pressed("jump"):
				_on_jump()
			else:
				_on_run()
			velocity.x -= GameManager.SPEED_RUN * delta
	else:
		animated_sprite_2d.play("jump")

func _on_run():
	if (Input.is_action_pressed("run") || Input.is_action_pressed("backward")):
		animated_sprite_2d.play("run")

func _on_jump():
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = GameManager.HEIGHT_JUMP
			jump_sfx.play()

func _on_duck():
	if (Input.is_action_pressed("duck")):
		animated_sprite_2d.play("duck")

func _change_col():
	if (Input.is_action_pressed("duck")):
		run_col.disabled = true
	else:
		run_col.disabled = false

func _on_game():
	animated_sprite_2d.play("run")
