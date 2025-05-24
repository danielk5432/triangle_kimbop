extends Card

signal card_selected()
signal card_deselected()

@export var move_pos: Vector2 = Vector2(0, -40)
@export var move_time: float = 0.1

@export var unselected_level = 0
@export var selected_level = 1

var card_activated := false
var move_tween: Tween = null

func _ready():
	super._ready()
	$Sample.free()
	for i in range(10):
		await get_tree().process_frame
	initial_position = global_position


func on_button_down() -> void:
	if Global.selectable:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			# 드래그 시작
			dragging = true
			dragging_offset = get_global_mouse_position() - global_position

		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			card_activated = !card_activated

			var target_pos: Vector2
			if card_activated:
				target_pos = initial_position + move_pos
				card_selected.emit()
				$Index.visible = true
				animate_scale(Vector2(1.2, 1.2))
				z_index = selected_level
				
			else:
				target_pos = initial_position
				card_deselected.emit()
				$Index.visible = false
				animate_scale(Vector2(1, 1))
				z_index = unselected_level

			handle_movement(target_pos, true, move_time)

func deselect():
	var target_pos = initial_position
	$Index.visible = false
	animate_scale(Vector2(1, 1))
	z_index = unselected_level
	handle_movement(target_pos, true, move_time)


func on_button_up() -> void:
	dragging = false
	card_texture.reset_shader_rot()

	var target_pos: Vector2
	if card_activated:
		target_pos = initial_position + move_pos
	else:
		target_pos = initial_position
		animate_scale(Vector2(1, 1))  # 선택 해제 시 크기 복귀

	handle_movement(target_pos, true, move_time)



func on_dragged() -> void:
	if !is_draggable or !dragging:
		return

	var new_pos = get_global_mouse_position() - dragging_offset
	handle_movement(new_pos, true, 0.05)


func handle_movement(_move_to: Vector2, is_global: bool = false, _duration: float = 0.1):
	if move_tween:
		move_tween.kill()
	move_tween = create_tween()

	if is_global:
		move_tween.tween_property(self, "global_position", _move_to, _duration)
	else:
		move_tween.tween_property(self, "position", _move_to, _duration)

func handle_movement_r(_move_to: Vector2, is_global: bool = false, _duration: float = 0.1):
	if move_tween:
		move_tween.kill()
	move_tween = create_tween()

	if is_global:
		move_tween.tween_property(self, "global_position", _move_to, _duration)
	else:
		move_tween.tween_property(self, "position", _move_to, _duration)
	move_tween.finished.connect(func():
			initial_position = _move_to
	)

func animate_scale(target_scale: Vector2, duration: float = 0.1):
	var scale_tween := create_tween()
	scale_tween.tween_property(self, "scale", target_scale, duration)

func reset_texture():
	shadow_card.texture = current_texture
	card_texture.texture = current_texture

	
func set_required():
	super.set_required()
	move_child(card_texture, 0)
	move_child(shadow_card, 0)

func set_tooltip():
	if !CardGlobal.use_tooltips:
		return
	match current_texture:
		back_texture:
			tooltip_text = "Press MB2 to flip"
		face_texture:
			tooltip_text = card_resource.card_description
