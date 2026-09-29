extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY=1000
const speed = 400

enum State {Idle, Run, Jump}

var current_state
func _ready():

	current_state=State.Idle

func _physics_process(delta):

	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide() 

	player_animation()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
func player_idle(_delta):
	if is_on_floor():
		current_state=State.Idle
	print("state", State.keys()[current_state])

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x =move_toward(velocity.x, 0, speed)
	if direction!=0:
		current_state= State.Run
		animated_sprite_2d.flip_h = false if direction > 0  else true

func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y = -200
		current_state = State.Jump  

func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state ==  State.Run:

		animated_sprite_2d.play("Jump")
	else:
		animated_sprite_2d.play("Run")
