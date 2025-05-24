class_name FireballCard
extends BaseCard

func _init():
	card_data = FireballData.new()

func run(p_list : Array[Passive] , result : Result, c_list : Array[BaseCard]):
	# passive 에 추
	return super.run(p_list, result, c_list)
	
