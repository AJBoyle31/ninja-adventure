extends KinematicBody2D
class_name Player

const SPEED: int = 100

var velocity: Vector2 = Vector2.ZERO
var player_state
var current_weapon

enum State { IDLE, WALK, ATTACK }


onready var player_animation_player: AnimationPlayer = $PlayerAnimationPlayer
onready var player_animation_tree: AnimationTree = $PlayerAnimationTree
onready var player_animation_state = player_animation_tree.get("parameters/playback")
onready var player_weapons = $WeaponPosition2D/Weapon

func _ready() -> void:
	player_animation_tree.active = true
	player_state = State.IDLE
	current_weapon = player_weapons.get_child(0)

func _physics_process(_delta) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction.length() == 0:
		player_state = State.IDLE
	else:
		if player_state != State.ATTACK:
			player_state = State.WALK
	
	if Input.is_action_just_pressed("attack"):
		player_state = State.ATTACK
	
	match player_state:
		State.IDLE:
			idle_state()
		State.WALK:
			walk_state(direction)
		State.ATTACK:
			attack_state()
	



func move_player() -> void:
	velocity = move_and_slide(velocity)

func idle_state() -> void:
	player_animation_state.travel("Idle")
	velocity = Vector2.ZERO
	move_player()

func walk_state(_direction) -> void:
	player_animation_state.travel("Walk")
	velocity = _direction * SPEED
	player_animation_tree.set("parameters/Idle/blend_position", _direction)
	player_animation_tree.set("parameters/Walk/blend_position", _direction)
	player_animation_tree.set("parameters/Attack/blend_position", _direction)
	move_player()

func attack_state() -> void:
	velocity = Vector2.ZERO
	player_animation_state.travel("Attack")
	move_player()


func set_player_state_to_idle() -> void:
	player_state = State.IDLE




func _on_Stats_no_health():
	print("dead")
