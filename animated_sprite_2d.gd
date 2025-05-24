extends AnimatedSprite2D

var isattack = false
var isbutton = false

func _ready() -> void:
	play("default")

func _process(delta: float) -> void:
	if isattack != true:
		play("default")

func _input(event): 
	if event.is_action_pressed("Enter") or isbutton == true:
		isattack = true
		play("attack")
	
func _on_animation_finished() -> void:
	if animation == "attack":
		isattack = false
		isbutton = false
		

func _on_button_pressed() -> void:
	isbutton = true
