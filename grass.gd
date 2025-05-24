extends Node2D

@export var speed: float = 100.0  # 초당 이동 속도
@export var reset_threshold: float = -1137.364  # 리셋 기준값

func _process(delta: float) -> void:
	position.x -= speed * delta  # 왼쪽으로 이동
	
	if position.x <= reset_threshold:
		position.x = -606.45  # 다시 오른쪽으로 초기화
