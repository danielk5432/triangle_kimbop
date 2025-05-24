extends Node2D

@export var speed: float = 100.0  # 초당 이동 속도
@export var reset_threshold: float = -1152.0  # 리셋 기준값

func _process(delta: float) -> void:
	position.x -= speed * delta  # 왼쪽으로 이동
	
	if position.x <= reset_threshold:
		position.x = 0  # 다시 오른쪽으로 초기화
