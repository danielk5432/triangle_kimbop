extends Node2D

@export var interval = 0.1 # n초 (기본값 1초)
var time_passed = 0.0  # 누적 시간

func _process(delta):
	time_passed += delta
	
	if time_passed >= interval:
		position.x -= 0.1
		time_passed = 0.0  # 초기화
