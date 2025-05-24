extends Area2D

@export var speed = 400
var screen_size
var viewing = false
var view_f = 0
var f = 0
var l = 9
var size = 5
var arr = []
var excard_L = [1, 5, '+', '-', 7, 9, 'x', '-', 5, 3]

func _ready():
	# 카드 배열 초기화
	arr.resize(20)
	for i in range(excard_L.size()):
		arr[i] = excard_L[i]

func _process(delta):
	$AnimatedSprite2D.play()

	if Input.is_action_just_pressed("Excape"):
		viewing = not viewing  # 토글: 보기 시작/종료

	if viewing:
		draw_card_view()

func draw_card_view():
	# 범위 보정
	if view_f < f:
		view_f = l
	elif view_f > l:
		view_f = f

	# 카드 출력
	var index = view_f
	var output = ""
	for i in range(size):
		if index > l:
			index = f
		output += str(arr[index]) + " "
		index += 1
	

	# 방향키 입력 처리
	if Input.is_action_just_pressed("Right"):
		view_f += 1
		print(output)
	elif Input.is_action_just_pressed("Left"):
		view_f -= 1
		print(output)
