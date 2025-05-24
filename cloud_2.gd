extends Node2D

@export var speed: float = 50  # 초당 이동 속도
@export var reset_threshold: float = -1138.313  # 리셋 기준값

func _process(delta: float) -> void:
	position.x -= speed * delta  # 왼쪽으로 이동
	
	if position.x <= reset_threshold:
		position.x = -608.61  # 다시 오른쪽으로 초기화
