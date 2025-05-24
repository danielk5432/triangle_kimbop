extends AnimatedSprite2D

var isattack = false

func _ready() -> void:
	play("default")

func _process(delta: float) -> void:
	if isattack != true:
		play("default")

func _input(event): 
	if event.is_action_pressed("Enter"):
		isattack = true
		play("attack")
	

func _on_animation_finished() -> void:
	if animation == "attack":
		isattack = false
