extends KinematicBody2D
class_name Animal

export var animal_speed: int = 100

var animal_state
export var animal_direction: int = 1

onready var animal_animation_player: AnimationPlayer = $AnimalAnimationPlayer

enum State { IDLE, WALK }

func _ready() -> void:
	animal_state = State.IDLE
	animal_animation_player.play("idle")


